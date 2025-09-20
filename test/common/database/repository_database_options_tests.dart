import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/common/database/database_manager.dart';
import 'package:simplerestic/common/models/repository_model.dart';
import 'package:simplerestic/common/utils/abstraction_layer.dart';

class MockDirectoryPathProvider extends Mock implements DirectoryPathProvider {}

void main() {
  group(
      "Asserts that the repository options of the DatabaseManager work as expected",
      () {
    late MockDirectoryPathProvider mockDirectoryPathProvider;
    late DatabaseManager databaseManager;
    late Directory tempFolder;
    late RepositoryModel dummyModel;

    setUp(() {
      mockDirectoryPathProvider = MockDirectoryPathProvider();
      databaseManager = DatabaseManager(
        directoryPathProvider: mockDirectoryPathProvider,
      );
      tempFolder = Directory.systemTemp.createTempSync();

      when(() =>
              mockDirectoryPathProvider.getApplicationDocumentsDirectoryPath())
          .thenAnswer((_) => Future.value(tempFolder.path));

      dummyModel = RepositoryModel(
        path: "testPath",
        passwordFile: "testPasswordFile",
        snapshotInterval: Duration(seconds: 10),
        alias: "testAlias",
      );
    });

    tearDown(() {
      tempFolder.deleteSync(recursive: true);
    });

    test("Assert that initially no repositories are existent.", () async {
      expect(await databaseManager.getRepositories(), []);
    });

    test(
        "Assert that insertRepository inserts Repository and adds the id to the model.",
        () async {
      dummyModel = await databaseManager.insertRepository(dummyModel);

      expect(dummyModel.id, isNotNull);
    });

    test("Assert that getRepositories correctly fetches the repositories",
        () async {
      await databaseManager.insertRepository(dummyModel);
      await databaseManager.insertRepository(dummyModel);

      expect(await databaseManager.getRepositories(), hasLength(2));
    });

    test(
        "Assert that getRepositoryById correctly fetches the repository with the given id",
        () async {
      dummyModel = await databaseManager.insertRepository(dummyModel);

      expect(
        (await databaseManager.getRepositoryById(dummyModel.id!))!.toMap(),
        dummyModel.toMap(),
      );
    });

    test("Assert that updateRepository correctly updates the repository",
        () async {
      dummyModel = await databaseManager.insertRepository(dummyModel);

      dummyModel.passwordFile = "testPasswordFile2";
      dummyModel.snapshotInterval = Duration(minutes: 10);

      await databaseManager.updateRepository(dummyModel);

      expect(
        (await databaseManager.getRepositoryById(dummyModel.id!))!.toMap(),
        dummyModel.toMap(),
      );
    });

    test(
        "Assert that deleteRepository correctly deletes a repository form the database",
        () async {
      dummyModel = await databaseManager.insertRepository(dummyModel);

      expect(await databaseManager.getRepositories(), hasLength(1));

      await databaseManager.deleteRepository(dummyModel);

      expect(await databaseManager.getRepositories(), hasLength(0));
    });
  });
}

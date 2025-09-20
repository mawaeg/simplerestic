import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/common/database/database_manager.dart';
import 'package:simplerestic/common/models/repository_model.dart';
import 'package:simplerestic/common/models/snapshot_model.dart';
import 'package:simplerestic/common/utils/abstraction_layer.dart';

class MockDirectoryPathProvider extends Mock implements DirectoryPathProvider {}

void main() {
  group(
      "Asserts that the snapshot options of the DatabaseManager work as expected",
      () {
    late MockDirectoryPathProvider mockDirectoryPathProvider;
    late DatabaseManager databaseManager;
    late Directory tempFolder;
    late SnapshotModel dummyModel;

    setUp(() async {
      mockDirectoryPathProvider = MockDirectoryPathProvider();
      databaseManager = DatabaseManager(
        directoryPathProvider: mockDirectoryPathProvider,
      );
      tempFolder = Directory.systemTemp.createTempSync();

      when(() =>
              mockDirectoryPathProvider.getApplicationDocumentsDirectoryPath())
          .thenAnswer((_) => Future.value(tempFolder.path));

      // Insert repository for FOREING KEY constraint
      await databaseManager.insertRepository(
        RepositoryModel(
          path: "test",
          passwordFile: "test",
          snapshotInterval: Duration(seconds: 1),
        ),
      );

      dummyModel = SnapshotModel(
        repositoryId: 1,
        path: ["testPath"],
        alias: "testAlias",
      );
    });

    tearDown(() {
      tempFolder.deleteSync(recursive: true);
    });

    test("Assert that initially no snapshots are existent.", () async {
      expect(await databaseManager.getSnapshots(), []);
    });

    test(
        "Assert that insertSnapshot inserts Snapshot and adds the id to the model.",
        () async {
      dummyModel = await databaseManager.insertSnapshot(dummyModel);

      expect(dummyModel.id, isNotNull);
    });

    test("Assert that getSnapshots correctly fetches the snapshots", () async {
      await databaseManager.insertSnapshot(dummyModel);
      await databaseManager.insertSnapshot(dummyModel);

      expect(await databaseManager.getSnapshots(), hasLength(2));
    });

    test(
        "Assert that getSnapshotById correctly fetches the snapshot with the given id",
        () async {
      dummyModel = await databaseManager.insertSnapshot(dummyModel);

      expect(
        (await databaseManager.getSnapshotById(dummyModel.id!))!.toMap(),
        dummyModel.toMap(),
      );
    });

    test(
        "Assert that getSnapshotByPath correctly fetches the snapshot with the given id",
        () async {
      dummyModel = await databaseManager.insertSnapshot(dummyModel);

      expect(
        (await databaseManager.getSnapshotByPath(
          dummyModel.repositoryId,
          dummyModel.path,
        ))!
            .toMap(),
        dummyModel.toMap(),
      );
    });

    test("Assert that updateSnapshot correctly updates the snapshot", () async {
      dummyModel = await databaseManager.insertSnapshot(dummyModel);

      dummyModel.alias = "testAlias2";

      await databaseManager.updateSnapshot(1, dummyModel);

      expect(
        (await databaseManager.getSnapshotById(dummyModel.id!))!.toMap(),
        dummyModel.toMap(),
      );
    });

    test(
        "Assert that deleteSnapshot correctly deletes a snapshot form the database",
        () async {
      dummyModel = await databaseManager.insertSnapshot(dummyModel);

      expect(await databaseManager.getSnapshots(), hasLength(1));

      await databaseManager.deleteSnapshot(dummyModel);

      expect(await databaseManager.getSnapshots(), hasLength(0));
    });

    test(
        "Assert that deleteSnapshotByPath correctly deletes a snapshot form the database",
        () async {
      dummyModel = await databaseManager.insertSnapshot(dummyModel);

      expect(await databaseManager.getSnapshots(), hasLength(1));

      await databaseManager.deleteSnapshotByPath(
        dummyModel.repositoryId,
        dummyModel.pathList,
      );

      expect(await databaseManager.getSnapshots(), hasLength(0));
    });
  });
}

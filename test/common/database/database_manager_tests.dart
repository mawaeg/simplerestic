import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/common/database/database_manager.dart';
import 'package:simplerestic/common/utils/abstraction_layer.dart';

class MockDirectoryPathProvider extends Mock implements DirectoryPathProvider {}

void main() {
  group("Asserts that the DatabaseManager works as expected", () {
    // init is not tested here, as it is expected to work correctly when the options work as expected.
    late MockDirectoryPathProvider mockDirectoryPathProvider;
    late DatabaseManager databaseManager;
    late Directory tempFolder;

    setUp(() {
      mockDirectoryPathProvider = MockDirectoryPathProvider();
      databaseManager = DatabaseManager(
        directoryPathProvider: mockDirectoryPathProvider,
      );
      tempFolder = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      tempFolder.deleteSync(recursive: true);
    });

    test(
        "Assert that the getDBPathAndCreateFileIfNotExists function works as expected.",
        () async {
      when(() =>
              mockDirectoryPathProvider.getApplicationDocumentsDirectoryPath())
          .thenAnswer((_) => Future.value(tempFolder.path));

      String path = await databaseManager.getDBPathAndCreateFileIfNotExists();
      String expectedPath = "${tempFolder.path}/simplerestic/db/database.db";

      expect(File(expectedPath).existsSync(), isTrue);
      expect(path, expectedPath);
    });
  });
}

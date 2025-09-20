import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../utils/abstraction_layer.dart';
import 'options/repository_database_options.dart';
import 'options/snapshot_database_options.dart';

/// This class bundles all DatabaseOption mixins to one point.
class DatabaseManager with RepositoryDatabaseOptions, SnapshotDatabaseOptions {
  final DirectoryPathProvider directoryPathProvider;

  const DatabaseManager({
    this.directoryPathProvider = const DirectoryPathProvider(),
  });

  Future<String> getDBPathAndCreateFileIfNotExists() async {
    String appDocDirPath =
        await directoryPathProvider.getApplicationDocumentsDirectoryPath();
    File datbaseFile =
        await File(join(appDocDirPath, "simplerestic/db/database.db"))
            .create(recursive: true);

    return datbaseFile.path;
  }

  /// Initializes the database.
  @override
  Future<Database> init() async {
    sqfliteFfiInit();
    String path = await getDBPathAndCreateFileIfNotExists();
    var databaseFactory = databaseFactoryFfi;
    Database database = await databaseFactory.openDatabase(path);

    // Enable FOREIGN KEYs
    await database.execute("PRAGMA foreign_keys = ON");

    await database.execute(
        "CREATE TABLE IF NOT EXISTS repositories (id INTEGER PRIMARY KEY NOT NULL, path TEXT NOT NULL, passwordFile TEXT NOT NULL, snapshotInterval INTEGER NOT NULL, alias TEXT);");
    await database.execute(
        "CREATE TABLE IF NOT EXISTS snapshots (id INTEGER PRIMARY KEY NOT NULL, repositoryId INTEGER NOT NULL, path TEXT NOT NULL, alias TEXT, CONSTRAINT repositoryIdFK FOREIGN KEY(repositoryId) REFERENCES repositories(id) ON DELETE CASCADE);");

    return database;
  }

  /// Closes the connection to the database.
  @override
  Future<void> close(Database database) async {
    await database.close();
  }
}

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'options/repository_database_options.dart';
import 'options/snapshot_database_options.dart';

/// This class bundles all DatabaseOption mixins to one point.
class DatabaseManager with RepositoryDatabaseOptions, SnapshotDatabaseOptions {

  Future<String> getDBPathAndCreateFileIfNotExists() async{
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File datbaseFile = await File(join(appDocDir.path, "simplerestic/db/database.db")).create(recursive: true);

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

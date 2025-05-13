import 'package:sqflite/sqlite_api.dart';

import 'database_options_base.dart';
import '../../models/snapshot_model.dart';

mixin SnapshotDatabaseOptions implements DatabaseOptionsBase {
  Future<SnapshotModel> insertSnapshot(SnapshotModel snapshot) async {
    Database database = await init();
    int id = await database.insert(
      "snapshots",
      snapshot.toMap(),
    );
    await close(database);
    return SnapshotModel(
      id: id,
      repositoryId: snapshot.repositoryId,
      path: snapshot.pathList,
      alias: snapshot.alias,
    );
  }

  Future<void> updateSnapshot(SnapshotModel snapshot) async {
    Database database = await init();
    await database.update(
      "snapshots",
      snapshot.toMap(),
      where: "id = ?",
      whereArgs: [snapshot.id],
    );
  }

  Future<List<SnapshotModel>> getSnapshots() async {
    Database database = await init();
    final List<Map<String, dynamic>> maps = await database.query("snapshots");
    await close(database);

    return List.generate(maps.length, (index) {
      return SnapshotModel.fromMap(maps[index]);
    });
  }

  Future<SnapshotModel?> getSnapshotById(int id) async {
    Database database = await init();
    final List<Map<String, dynamic>> maps = await database.query(
      "snapshots",
      where: "id = ?",
      whereArgs: [id],
    );
    Map<String, dynamic>? snapshot = maps.firstOrNull;
    if (snapshot == null) {
      return null;
    }
    return SnapshotModel.fromMap(snapshot);
  }

  Future<SnapshotModel?> getSnapshotByPath(
    int repositoryId,
    String path,
  ) async {
    Database database = await init();
    final List<Map<String, dynamic>> maps = await database.query(
      "snapshots",
      where: "repositoryId = ? AND path = ?",
      whereArgs: [repositoryId, path],
    );
    Map<String, dynamic>? snapshot = maps.firstOrNull;
    if (snapshot == null) {
      return null;
    }
    return SnapshotModel.fromMap(snapshot);
  }

  Future<void> deleteSnapshot(SnapshotModel snapshot) async {
    Database database = await init();
    await database.delete(
      "snapshots",
      where: "id = ?",
      whereArgs: [snapshot.id],
    );
    await close(database);
  }

  Future<void> deleteSnapshotByPath(int repositoryId, List<String> path) async {
    Database database = await init();
    await database.delete(
      "snapshots",
      where: "repositoryId = ? AND path = ?",
      whereArgs: [repositoryId, SnapshotModel.getPathListAsString(path)],
    );
    await close(database);
  }
}

import 'package:sqflite/sqlite_api.dart';

import '../../models/repository_model.dart';
import 'database_options_base.dart';

mixin RepositoryDatabaseOptions implements DatabaseOptionsBase {
  Future<RepositoryModel> insertRepository(RepositoryModel repository) async {
    Database database = await init();
    int id = await database.insert(
      "repositories",
      repository.toMap(),
    );
    await close(database);
    return RepositoryModel(
      id: id,
      path: repository.path,
      passwordFile: repository.passwordFile,
      snapshotInterval: repository.snapshotInterval,
      alias: repository.alias,
    );
  }

  Future<void> updateRepository(RepositoryModel repository) async {
    Database database = await init();
    await database.update(
      "repositories",
      repository.toMap(),
      where: "id = ?",
      whereArgs: [repository.id],
    );
  }

  Future<List<RepositoryModel>> getRepositories() async {
    Database database = await init();
    final List<Map<String, dynamic>> maps =
        await database.query("repositories");
    await close(database);

    return List.generate(maps.length, (index) {
      return RepositoryModel.fromMap(maps[index]);
    });
  }

  Future<RepositoryModel?> getRepositoryById(int id) async {
    Database database = await init();
    final List<Map<String, dynamic>> maps = await database.query(
      "repositories",
      where: "id = ?",
      whereArgs: [id],
    );
    Map<String, dynamic>? repository = maps.firstOrNull;
    if (repository == null) {
      return null;
    }
    return RepositoryModel.fromMap(repository);
  }

  Future<void> deleteRepository(RepositoryModel repository) async {
    Database database = await init();
    await database
        .delete("repositories", where: "id = ?", whereArgs: [repository.id]);
    await close(database);
  }
}

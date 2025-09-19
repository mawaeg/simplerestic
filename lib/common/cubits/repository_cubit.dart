import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/database_manager.dart';
import '../models/repository_model.dart';

class RepositoryCubit extends Cubit<List<RepositoryModel>> {
  final DatabaseManager databaseManager;
  RepositoryCubit(this.databaseManager) : super(const []);

  Future<void> init() async {
    final repositories = await databaseManager.getRepositories();
    emit(repositories);
  }

  Future<void> addRepository(RepositoryModel repository) async {
    final newModel = await databaseManager.insertRepository(repository);
    emit(List.of(state)..add(newModel));
  }

  Future<void> updateRepository(RepositoryModel repository) async {
    await databaseManager.updateRepository(repository);
    int index = state.indexWhere((element) => element.id == repository.id);
    emit(
      List.of(state)
        ..removeAt(index)
        ..insert(index, repository),
    );
  }

  Future<void> removeRepository(RepositoryModel repository) async {
    await databaseManager.deleteRepository(repository);
    emit(List.of(state)..remove(repository));
  }
}

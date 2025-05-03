import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/database_manager.dart';
import '../models/repository_model.dart';

class RepositoryCubit extends Cubit<List<RepositoryModel>> {
  RepositoryCubit() : super(const []);

  void init() async {
    final repositories = await DatabaseManager().getRepositories();
    emit(repositories);
  }

  void addRepository(RepositoryModel repository) async {
    final newModel = await DatabaseManager().insertRepository(repository);
    emit(List.of(state)..add(newModel));
  }

  void removeRepository(RepositoryModel repository) async {
    await DatabaseManager().deleteRepository(repository);
    emit(List.of(state)..remove(repository));
  }
}

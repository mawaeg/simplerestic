import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/repository_list_model.dart';
import '../models/repository_model.dart';

class RepositoryListCubit extends HydratedCubit<RepositoryListModel> {
  RepositoryListCubit() : super(RepositoryListModel());

  void addRepository(RepositoryModel repository, {int? index}) {
    // Even though RepositoryListModel is Equatable the onChange is not triggered in emit when just updating the state
    final List<RepositoryModel> modelList;
    if (index == null) {
      modelList = List.of(state.getRepositories())..add(repository);
    } else {
      modelList = List.of(state.getRepositories())..insert(index, repository);
    }
    final model = RepositoryListModel(repositories: modelList);
    emit(model);
  }

  void removeRepository(RepositoryModel repository) {
    final modelList = List.of(state.getRepositories())..remove(repository);
    final model = RepositoryListModel(repositories: modelList);
    emit(model);
  }

  void addRepositorySnapshot(
      RepositoryModel repository, String path, String alias) {
    // Using this hack to be able to detect state changes when just updating the list.
    int index = state.getRepositories().indexOf(repository);
    removeRepository(repository);
    repository.addSnapshot(path, alias);
    addRepository(repository, index: index);
  }

  void removeRepositorySnapshot(RepositoryModel repository, String path) {
    int index = state.getRepositories().indexOf(repository);
    removeRepository(repository);
    repository.removeSnapshot(path);
    addRepository(repository, index: index);
  }

  @override
  RepositoryListModel fromJson(Map<String, dynamic> json) {
    return RepositoryListModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RepositoryListModel state) {
    return state.toJson();
  }
}

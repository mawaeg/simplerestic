import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/repository_list_model.dart';
import '../models/repository_model.dart';

class RepositoryListCubit extends HydratedCubit<RepositoryListModel> {
  RepositoryListCubit() : super(RepositoryListModel());

  void addRepository(RepositoryModel repository) {
    // Even though RepositoryListModel is Equatable the onChange is not triggered in emit when just updating the state
    final modelList = List.of(state.getRepositories())..add(repository);
    final model = RepositoryListModel(repositories: modelList);
    emit(model);
  }

  void removeRepository(RepositoryModel repository) {
    final modelList = List.of(state.getRepositories())..remove(repository);
    final model = RepositoryListModel(repositories: modelList);
    emit(model);
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

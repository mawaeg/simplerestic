import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/repository_list_model.dart';
import '../models/repository_model.dart';

class RepositoryListCubit extends HydratedCubit<RepositoryListModel> {
  RepositoryListCubit() : super(RepositoryListModel());

  void addRepository(RepositoryModel repository) {
    state.addRepository(repository);
    emit(state);
  }

  void removeRepository(RepositoryModel repository) {
    state.removeRepository(repository);
    emit(state);
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

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/create_repository_model.dart';

class CreateRepositoryCubit extends Cubit<CreateRepositoryModel> {
  CreateRepositoryCubit() : super(CreateRepositoryModel());

  void setPath(String? path) {
    state.path = path;
    emit(state);
  }

  void setPasswordFile(String? passwordFile) {
    state.passwordFile = passwordFile;
    emit(state);
  }

  void setAlias(String? alias) {
    state.alias = alias;
    emit(state);
  }
}

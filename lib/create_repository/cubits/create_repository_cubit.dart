import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/snapshot_interval_options_enum.dart';
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

  void setInterval(int interval, SnapshotIntervalOptionsEnum intervalOption) {
    final Duration duration;
    switch (intervalOption) {
      case SnapshotIntervalOptionsEnum.hours:
        duration = Duration(hours: interval);
        break;
      case SnapshotIntervalOptionsEnum.days:
        duration = Duration(days: interval);
        break;
      case SnapshotIntervalOptionsEnum.weeks:
        duration = Duration(days: interval * 7);
        break;
      case SnapshotIntervalOptionsEnum.months:
        duration = Duration(days: interval * 31);
        break;
      case SnapshotIntervalOptionsEnum.years:
        duration = Duration(days: interval * 365);
        break;
    }
    state.snapshotInterval = duration;
    emit(state);
  }

  void setIsSuccessful(bool isSuccessful) {
    state.isSuccessful = isSuccessful;
    emit(state);
  }

  void clear() {
    state.clear();
    emit(state);
  }
}

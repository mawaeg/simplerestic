import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/restic_command/base/restic_command_option_type.dart';
import '../models/restore_snapshot_model.dart';

class RestoreSnapshotCubit extends Cubit<RestoreSnapshotModel> {
  RestoreSnapshotCubit() : super(RestoreSnapshotModel());

  void setTarget(String target) {
    state.target = target;
    emit(state);
  }

  void setOverwriteStrategy(ResticOverwriteOptionTypeValues overwriteStrategy) {
    state.overwriteStrategy = overwriteStrategy;
    emit(state);
  }

  void setDelete(bool delete) {
    emit(
      RestoreSnapshotModel(
        target: state.target,
        overwriteStrategy: state.overwriteStrategy,
        delete: delete,
        inplaceRestore: state.inplaceRestore,
        warningsAccepted: state.warningsAccepted,
      ),
    );
  }

  void setInplaceRestore(bool inplaceRestore) {
    emit(
      RestoreSnapshotModel(
        target: state.target,
        overwriteStrategy: state.overwriteStrategy,
        delete: state.delete,
        inplaceRestore: inplaceRestore,
        warningsAccepted: state.warningsAccepted,
      ),
    );
  }

  void setWarningsAccepted(bool warningsAccepted) {
    emit(RestoreSnapshotModel(
      target: state.target,
      overwriteStrategy: state.overwriteStrategy,
      delete: state.delete,
      inplaceRestore: state.inplaceRestore,
      warningsAccepted: warningsAccepted,
    ));
  }

  void clearData() {
    emit(RestoreSnapshotModel());
  }
}

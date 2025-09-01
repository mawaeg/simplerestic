import '../../backend/restic_command/base/restic_command_option_type.dart';

class RestoreSnapshotModel {
  String? target;
  ResticOverwriteOptionTypeValues overwriteStrategy;
  bool delete = false;

  RestoreSnapshotModel({
    this.target,
    this.overwriteStrategy = ResticOverwriteOptionTypeValues.always,
    this.delete = false,
  });
}

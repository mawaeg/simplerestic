import '../restic_types/base/restic_json_type.dart';
import '../restic_types/primitives/snapshots/restic_snapshots_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_type.dart';

class ResticCommandSnapshots extends ResticCommandCli {
  ResticCommandSnapshots({
    required super.repository,
    required super.passwordFile,
  }) : super(type: ResticCommandType.snapshots);

  @override
  ResticJsonType? parseJson(dynamic json) {
    if (json.runtimeType == List) {
      return ResticSnapshotsType.fromJson(json);
    }
    return null;
  }
}

import '../restic_types/base/restic_json_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_flag_type.dart';
import 'base/restic_command_type.dart';

class ResticCommandForget extends ResticCommandCli {
  /// The snapshot id which should be forgotten
  final String snapshotId;

  /// determines whether prune should be executed to remove unreferenced data
  final bool prune;

  ResticCommandForget({
    required super.repository,
    required super.passwordFile,
    required this.snapshotId,
    this.prune = false,
  }) : super(
          type: ResticCommandType.forget,
          args: [snapshotId],
          flags: prune ? [ResticCommandFlagType.prune] : null,
        );

  @override
  ResticJsonType? parseJson(dynamic json) {
    // As we are currently just removing single snapshots, wo don't get any json output
    return null;
  }
}

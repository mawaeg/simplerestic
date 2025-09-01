import '../restic_types/base/restic_json_type.dart';
import '../restic_types/primitives/base/restic_base_error_type.dart';
import '../restic_types/primitives/restore/restic_restore_status_type.dart';
import '../restic_types/primitives/restore/restic_restore_summary_type.dart';
import '../utils/normalize_enum_name.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_flag_type.dart';
import 'base/restic_command_option_type.dart';
import 'base/restic_command_options.dart';
import 'base/restic_command_type.dart';

class ResticCommandRestore extends ResticCommandCli {
  /// The folder where the backup should be restored.
  final String target;

  /// The id which should be restored.
  final String snapshotId;

  /// Whether files not in the snapshot should be deleted
  final bool delete;

  /// The overwrite strategy that should be used
  final ResticOverwriteOptionTypeValues overwriteStrategy;

  /// An optional path that should be restored.
  final String? path;

  ResticCommandRestore({
    required super.repository,
    required super.passwordFile,
    required this.target,
    required this.snapshotId,
    this.delete = false,
    this.overwriteStrategy = ResticOverwriteOptionTypeValues.always,
    this.path,
  }) : super(
          type: ResticCommandType.restore,
          args: [path != null ? "$snapshotId:$path" : snapshotId],
          options: [
            ResticCommandOption(ResticCommandOptionType.target, target),
            ResticCommandOption(ResticCommandOptionType.overwrite,
                normalizeCommandEnum(overwriteStrategy.name, isOption: false))
          ],
          flags: delete ? [ResticCommandFlagType.delete] : null,
        );

  @override
  ResticJsonType? parseJson(dynamic json) {
    switch (json["message_type"]) {
      case "status":
        return ResticRestoreStatusType.fromJson(json);
      case "summary":
        return ResticRestoreSummaryType.fromJson(json);
      case "error":
        return ResticBaseErrorType.fromJson(json);
      default:
        return null;
    }
  }
}

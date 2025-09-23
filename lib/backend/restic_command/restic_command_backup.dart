import '../restic_types/base/restic_json_type.dart';
import '../restic_types/primitives/base/restic_base_error_type.dart';
import '../restic_types/primitives/backup/restic_backup_status_type.dart';
import '../restic_types/primitives/backup/restic_backup_summary_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_flag_type.dart';
import 'base/restic_command_type.dart';

class ResticCommandBackup extends ResticCommandCli {
  final List<String> path;
  final bool dryRun;

  ResticCommandBackup({
    required super.repository,
    required super.passwordFile,
    required this.path,
    this.dryRun = false,
  }) : super(
          type: ResticCommandType.backup,
          args: path,
          flags: dryRun ? [ResticCommandFlagType.dry_run] : null,
        );

  @override
  ResticJsonType? parseJson(dynamic json) {
    switch (json["message_type"]) {
      case "status":
        return ResticBackupStatusType.fromJson(json);
      case "summary":
        return ResticBackupSummaryType.fromJson(json);
      case "error":
        return ResticBaseErrorType.fromJson(json);
      default:
        return null;
    }
  }
}

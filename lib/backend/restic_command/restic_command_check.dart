import '../restic_types/base/restic_json_type.dart';
import '../restic_types/primitives/check/restic_check_summary_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_type.dart';

class ResticCommandCheck extends ResticCommandCli {
  ResticCommandCheck({
    required super.repository,
    required super.passwordFile,
  }) : super(type: ResticCommandType.check);

  @override
  ResticJsonType? parseJson(dynamic json) {
    switch (json["message_type"]) {
      case "summary":
        return ResticCheckSummaryType.fromJson(json);
      default:
        return null;
    }
  }
}

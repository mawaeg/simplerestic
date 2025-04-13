import '../restic_types/base/restic_json_type.dart';
import '../restic_types/primitives/stats/restic_stats_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_type.dart';

class ResticCommandStats extends ResticCommandCli {
  ResticCommandStats({
    required super.repository,
    required super.passwordFile,
  }) : super(type: ResticCommandType.stats);

  @override
  ResticJsonType? parseJson(json) {
    return ResticStatsType.fromJson(json);
  }
}

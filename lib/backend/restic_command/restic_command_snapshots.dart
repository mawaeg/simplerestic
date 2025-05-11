import '../restic_types/base/restic_json_type.dart';
import '../restic_types/primitives/snapshots/restic_grouped_snapshots_type.dart';
import '../restic_types/primitives/snapshots/restic_snapshots_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_option_type.dart';
import 'base/restic_command_options.dart';
import 'base/restic_command_type.dart';

class ResticCommandSnapshots extends ResticCommandCli {
  final ResticGroupByOptionTypeValues? groupBy;
  ResticCommandSnapshots({
    required super.repository,
    required super.passwordFile,
    this.groupBy,
  }) : super(
          type: ResticCommandType.snapshots,
          options: groupBy != null
              ? [
                  ResticCommandOption(
                    ResticCommandOptionType.group_by,
                    groupBy.name,
                  )
                ]
              : null,
        );

  @override
  ResticJsonType? parseJson(dynamic json) {
    if (json.runtimeType == List && json.isNotEmpty) {
      // Check if the result is grouped
      if (json[0]["group_key"] != null) {
        return ResticGroupedSnapshotsType.fromJson(json);
      }
      return ResticSnapshotsType.fromJson(json);
    }
    return null;
  }
}

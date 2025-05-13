import '../../backend/restic_command/base/restic_command_option_type.dart';
import '../../backend/restic_command/restic_command_snapshots.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/base/restic_scripting_base_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_grouped_snapshots_type.dart';
import 'get_sorted_snapshot_keys.dart';

Future<ResticGroupedSnapshotsType> createSnapshotListModel(
    String path, String passwordFile) async {
  List<ResticScriptingBaseType> result = await ResticCommandExecutor(
    ResticCommandSnapshots(
      repository: path,
      passwordFile: passwordFile,
      groupBy: ResticGroupByOptionTypeValues.paths,
    ),
  ).executeCommandAsync();
  return getSortedSnapshotKeys((result.first as ResticGroupedSnapshotsType));
}

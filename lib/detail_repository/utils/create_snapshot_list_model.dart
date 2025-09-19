import '../../backend/restic_command/base/restic_command_option_type.dart';
import '../../backend/restic_command/restic_command_snapshots.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/base/restic_scripting_base_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_grouped_snapshots_type.dart';
import 'get_sorted_snapshot_keys.dart';

/// Creates a per path grouped snapshot list model.
///
/// This first fetches all snapshots for the given repository grouped by path
/// Then it calls getSortedSnapshotKeys to sort the order of the keys based on the first created snapshot for the path.
/// The returned model is a ResticGroupedSnapshotsType.

class SnapshotListModelCreator {
  final ResticCommandExecutor commandExecutor;

  const SnapshotListModelCreator({
    this.commandExecutor = const ResticCommandExecutor(),
  });

  Future<ResticGroupedSnapshotsType> create(
      String path, String passwordFile) async {
    ResticCommandSnapshots command = ResticCommandSnapshots(
      repository: path,
      passwordFile: passwordFile,
      groupBy: ResticGroupByOptionTypeValues.paths,
    );
    List<ResticScriptingBaseType> result =
        await commandExecutor.executeCommandAsync(command);
    return getSortedSnapshotKeys((result.first as ResticGroupedSnapshotsType));
  }
}

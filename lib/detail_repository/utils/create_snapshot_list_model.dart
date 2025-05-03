import '../../backend/restic_command/restic_command_snapshots.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/base/restic_scripting_base_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_type.dart';
import '../models/snapshot_list_model.dart';

Future<SnapshotListModel> createSnapshotListModel(
    String path, String passwordFile) async {
  List<ResticScriptingBaseType> result = await ResticCommandExecutor(
    ResticCommandSnapshots(
      repository: path,
      passwordFile: passwordFile,
    ),
  ).executeCommandAsync();
  return SnapshotListModel(result.first as ResticSnapshotsType);
}

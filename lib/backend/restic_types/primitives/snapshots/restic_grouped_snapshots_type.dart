import 'restic_grouped_snapshot_key_type.dart';
import '../../base/restic_json_type.dart';
import 'restic_snapshots_object_type.dart';

/// Represents the json output for the snapshots command with group-by.
class ResticGroupedSnapshotsType extends ResticJsonType {
  final Map<ResticGroupedSnapshotKeyType, List<ResticSnapshotsObjectType>>
      snapshots;

  ResticGroupedSnapshotsType(this.snapshots);

  factory ResticGroupedSnapshotsType.fromJson(List<dynamic> json) {
    Map<ResticGroupedSnapshotKeyType, List<ResticSnapshotsObjectType>>
        snapshots = {};
    for (var snapshotGroup in json) {
      ResticGroupedSnapshotKeyType key =
          ResticGroupedSnapshotKeyType.fromJson(snapshotGroup["group_key"]);
      List<ResticSnapshotsObjectType> groupSnapshots = [];
      for (var snapshot in snapshotGroup["snapshots"]) {
        groupSnapshots.add(ResticSnapshotsObjectType.fromJson(snapshot));
      }
      snapshots[key] = groupSnapshots;
    }
    return ResticGroupedSnapshotsType(snapshots);
  }

  @override
  List<Object?> get props => [snapshots];
}

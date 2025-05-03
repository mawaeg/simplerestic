import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_type.dart';

class SnapshotListModel {
  final Map<String, List<ResticSnapshotsObjectType>> _snapshots = {};

  int get length => _snapshots.length;

  Map<String, List<ResticSnapshotsObjectType>> get snapshots => _snapshots;

  SnapshotListModel(ResticSnapshotsType snapshots) {
    for (ResticSnapshotsObjectType snapshot in snapshots.snapshots) {
      if (_snapshots[snapshot.paths.first] == null) {
        _snapshots[snapshot.paths.first] = [snapshot];
      } else {
        _snapshots[snapshot.paths.first]!.add(snapshot);
      }
    }
  }
}

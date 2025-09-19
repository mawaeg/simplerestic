import 'dart:collection';

import '../../backend/restic_types/primitives/snapshots/restic_grouped_snapshot_key_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_grouped_snapshots_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';

/// Sorts the keys given by the ResticGroupedSnapshotsType by the creation time of the first snapshot per key.
///
/// When filtering by path with restic, the order of the snapshots for a given path based on the creation time is correct
/// However the order of the keys itself is not deterministic.
/// Therefore we want to order the keys by the first snapshot creation time of each path:
///
/// path1:
/// - snapshot at 2023-10-01
/// - snapshot at 2023-10-02
/// path2:
/// - snapshot at 2023-09-30
/// - snapshot at 2023-10-03
///
/// However in this case we want the order to be the following:
/// path2:
/// - snapshot at 2023-09-30
/// - snapshot at 2023-10-03
/// path1:
/// - snapshot at 2023-10-01
/// - snapshot at 2023-10-02
///
/// The creation time gives a way to order them in a deterministic way.
ResticGroupedSnapshotsType getSortedSnapshotKeys(
    ResticGroupedSnapshotsType snapshots) {
  Map<ResticGroupedSnapshotKeyType, List<ResticSnapshotsObjectType>> sorted =
      SplayTreeMap.from(
          snapshots.snapshots,
          (key1, key2) => snapshots.snapshots[key1]!.first.time
              .compareTo(snapshots.snapshots[key2]!.first.time));
  return ResticGroupedSnapshotsType(sorted);
}

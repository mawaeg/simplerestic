import 'dart:collection';

import '../../backend/restic_types/primitives/snapshots/restic_grouped_snapshot_key_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_grouped_snapshots_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';

ResticGroupedSnapshotsType getSortedSnapshotKeys(
    ResticGroupedSnapshotsType snapshots) {
  Map<ResticGroupedSnapshotKeyType, List<ResticSnapshotsObjectType>> sorted =
      SplayTreeMap.from(
          snapshots.snapshots,
          (key1, key2) => snapshots.snapshots[key1]!.first.time
              .compareTo(snapshots.snapshots[key2]!.first.time));
  return ResticGroupedSnapshotsType(sorted);
}

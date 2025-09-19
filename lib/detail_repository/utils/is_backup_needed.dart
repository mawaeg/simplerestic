import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';
import '../../common/utils/abstraction_layer.dart';

bool isBackupNeeded(
    RepositoryModel repository, ResticSnapshotsObjectType snapshot,
    {DateTimeUtility dateTimeUtility = const DateTimeUtility()}) {
  if (repository.snapshotInterval.inSeconds == 0) {
    return false;
  }
  DateTime lastSnapshot = snapshot.time.toLocal();
  int minimumTime = dateTimeUtility
      .getDateTimeNow()
      .subtract(repository.snapshotInterval)
      .millisecondsSinceEpoch;
  return minimumTime >= lastSnapshot.millisecondsSinceEpoch;
}

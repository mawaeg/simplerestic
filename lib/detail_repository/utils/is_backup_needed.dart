import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';

bool isBackupNeeded(
    RepositoryModel repository, ResticSnapshotsObjectType snapshot) {
  if (repository.snapshotInterval.inSeconds == 0) {
    return false;
  }
  DateTime lastSnapshot = snapshot.time.toLocal();
  int minimumTime = DateTime.now()
      .subtract(repository.snapshotInterval)
      .millisecondsSinceEpoch;
  return minimumTime >= lastSnapshot.millisecondsSinceEpoch;
}

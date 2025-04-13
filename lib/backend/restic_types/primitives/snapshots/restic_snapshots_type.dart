import '../../base/restic_json_type.dart';
import 'restic_snapshots_object_type.dart';

/// Represents the json output for the snapshots command.
class ResticSnapshotsType extends ResticJsonType {
  final List<ResticSnapshotsObjectType> snapshots;

  ResticSnapshotsType(this.snapshots);

  factory ResticSnapshotsType.fromJson(List<dynamic> json) {
    List<ResticSnapshotsObjectType> snapshots = [];
    for (var snapshot in json) {
      snapshots.add(ResticSnapshotsObjectType.fromJson(snapshot));
    }
    return ResticSnapshotsType(snapshots);
  }

  @override
  List<Object?> get props => [snapshots];
}

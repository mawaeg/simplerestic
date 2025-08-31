import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';

class SnapshotsListCubit extends Cubit<List<ResticSnapshotsObjectType>> {
  SnapshotsListCubit() : super(const []);

  void setSnapshots(List<ResticSnapshotsObjectType> snapshots) {
    emit(snapshots);
  }

  void removeSnapshot(String id) {
    List<ResticSnapshotsObjectType> snapshots = List.of(state);
    snapshots.removeWhere((snapshot) => snapshot.id == id);
    emit(snapshots);
  }
}

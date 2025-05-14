import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/database_manager.dart';
import '../models/snapshot_model.dart';

class SnapshotCubit extends Cubit<List<SnapshotModel>> {
  SnapshotCubit() : super(const []);

  void init() async {
    final snapshots = await DatabaseManager().getSnapshots();
    emit(snapshots);
  }

  void addSnapshot(SnapshotModel snapshot) async {
    SnapshotModel newModel = await DatabaseManager().insertSnapshot(snapshot);
    emit(List.of(state)..add(newModel));
  }

  void updateSnapshot(int repositoryId, SnapshotModel snapshot) async {
    await DatabaseManager().updateSnapshot(repositoryId, snapshot);
    int index = state.indexWhere((element) => element.id == snapshot.id);
    emit(
      List.of(state)
        ..removeAt(index)
        ..insert(index, snapshot),
    );
  }

  void removeSnapshot(SnapshotModel snapshot) async {
    await DatabaseManager().deleteSnapshot(snapshot);
    emit(List.of(state)..remove(snapshot));
  }

  void removeSnapshotByPath(int repositoryId, List<String> path) async {
    await DatabaseManager().deleteSnapshotByPath(repositoryId, path);
    emit(
      List.of(state)
        ..removeWhere((element) =>
            element.repositoryId == repositoryId &&
            SnapshotModel.arePathListsIdentical(element.pathList, path)),
    );
  }
}

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

  void updateSnapshot(SnapshotModel snapshot) async {
    await DatabaseManager().updateSnapshot(snapshot);
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

  void removeSnapshotByPath(int repositoryId, String path) async {
    await DatabaseManager().deleteSnapshotByPath(repositoryId, path);
    emit(
      List.of(state)
        ..removeWhere((element) =>
            element.repositoryId == repositoryId && element.path == path),
    );
  }
}

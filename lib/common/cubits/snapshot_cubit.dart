import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/database_manager.dart';
import '../models/snapshot_model.dart';

class SnapshotCubit extends Cubit<List<SnapshotModel>> {
  final DatabaseManager databaseManager;
  SnapshotCubit(this.databaseManager) : super(const []);

  Future<void> init() async {
    final snapshots = await databaseManager.getSnapshots();
    emit(snapshots);
  }

  Future<void> addSnapshot(SnapshotModel snapshot) async {
    SnapshotModel newModel = await databaseManager.insertSnapshot(snapshot);
    emit(List.of(state)..add(newModel));
  }

  Future<void> updateSnapshot(int repositoryId, SnapshotModel snapshot) async {
    await databaseManager.updateSnapshot(repositoryId, snapshot);
    int index = state.indexWhere((element) => element.id == snapshot.id);
    emit(
      List.of(state)
        ..removeAt(index)
        ..insert(index, snapshot),
    );
  }

  Future<void> removeSnapshot(SnapshotModel snapshot) async {
    await databaseManager.deleteSnapshot(snapshot);
    emit(List.of(state)..remove(snapshot));
  }

  Future<void> removeSnapshotByPath(int repositoryId, List<String> path) async {
    await databaseManager.deleteSnapshotByPath(repositoryId, path);
    emit(
      List.of(state)
        ..removeWhere((element) =>
            element.repositoryId == repositoryId &&
            SnapshotModel.arePathListsIdentical(element.pathList, path)),
    );
  }
}

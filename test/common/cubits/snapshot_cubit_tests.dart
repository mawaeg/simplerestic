import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/common/cubits/snapshot_cubit.dart';
import 'package:simplerestic/common/models/snapshot_model.dart';

import 'repository_cubit_tests.dart';

void main() {
  group(SnapshotCubit, () {
    late SnapshotCubit snapshotCubit;
    late MockDatabaseManager mockDatabaseManager;

    setUp(() {
      mockDatabaseManager = MockDatabaseManager();
      snapshotCubit = SnapshotCubit(mockDatabaseManager);
    });

    test("initial state is []", () {
      expect(snapshotCubit.state, equals([]));
    });

    test("Assert that init correctly fetches data from the database manager",
        () async {
      SnapshotModel model = SnapshotModel(
        id: 0,
        repositoryId: 0,
        path: ["test"],
        alias: "Test",
      );

      when(() => mockDatabaseManager.getSnapshots())
          .thenAnswer((_) => Future.value([model]));

      await snapshotCubit.init();

      verify(() => mockDatabaseManager.getSnapshots()).called(1);

      expect(snapshotCubit.state, [model]);
    });

    test("Assert that addSnapshot correctly adds a snapshot", () async {
      SnapshotModel model = SnapshotModel(
        repositoryId: 0,
        path: ["test"],
        alias: "Test",
      );
      SnapshotModel modelWithId = SnapshotModel(
        id: 0,
        repositoryId: model.repositoryId,
        path: model.pathList,
        alias: model.alias,
      );
      when(() => mockDatabaseManager.insertSnapshot(model))
          .thenAnswer((_) => Future.value(modelWithId));

      await snapshotCubit.addSnapshot(model);

      verify(() => mockDatabaseManager.insertSnapshot(model)).called(1);

      expect(snapshotCubit.state, [modelWithId]);
    });

    test("Assert that updateSnapshot correctly updates the snapshot", () async {
      SnapshotModel model = SnapshotModel(
        id: 0,
        repositoryId: 0,
        path: ["test"],
        alias: "Test",
      );

      // Prepare to be able to update model
      when(() => mockDatabaseManager.insertSnapshot(model))
          .thenAnswer((_) => Future.value(model));
      await snapshotCubit.addSnapshot(model);

      SnapshotModel updatedModel = SnapshotModel(
        id: 0,
        repositoryId: model.repositoryId,
        path: model.pathList..add("Path2"),
        alias: "Updated",
      );

      when(() => mockDatabaseManager.updateSnapshot(
              model.repositoryId, updatedModel))
          .thenAnswer((_) => Future.value(null));

      await snapshotCubit.updateSnapshot(model.repositoryId, updatedModel);

      verify(() => mockDatabaseManager.updateSnapshot(
          model.repositoryId, updatedModel)).called(1);

      expect(snapshotCubit.state, [updatedModel]);
    });

    test("Assert that removeSnapshot correctly removes the snapshot", () async {
      SnapshotModel model = SnapshotModel(
        id: 0,
        repositoryId: 0,
        path: ["test"],
        alias: "Test",
      );

      // Prepare to be able to delete model
      when(() => mockDatabaseManager.insertSnapshot(model))
          .thenAnswer((_) => Future.value(model));
      await snapshotCubit.addSnapshot(model);

      when(() => mockDatabaseManager.deleteSnapshot(model))
          .thenAnswer((_) => Future.value(null));

      await snapshotCubit.removeSnapshot(model);

      verify(() => mockDatabaseManager.deleteSnapshot(model)).called(1);

      expect(snapshotCubit.state, []);
    });

    test("Assert that removeSnapshotByPath correctly removes the snapshot",
        () async {
      SnapshotModel model = SnapshotModel(
        id: 0,
        repositoryId: 0,
        path: ["test"],
        alias: "Test",
      );

      // Prepare to be able to delete model
      when(() => mockDatabaseManager.insertSnapshot(model))
          .thenAnswer((_) => Future.value(model));
      await snapshotCubit.addSnapshot(model);

      when(() => mockDatabaseManager.deleteSnapshotByPath(
              model.repositoryId, model.pathList))
          .thenAnswer((_) => Future.value(null));

      await snapshotCubit.removeSnapshotByPath(
          model.repositoryId, model.pathList);

      verify(() => mockDatabaseManager.deleteSnapshotByPath(
          model.repositoryId, model.pathList)).called(1);

      expect(snapshotCubit.state, []);
    });
  });
}

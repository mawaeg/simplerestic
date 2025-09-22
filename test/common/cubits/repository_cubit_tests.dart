import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/common/cubits/repository_cubit.dart';
import 'package:simplerestic/common/database/database_manager.dart';
import 'package:simplerestic/common/models/repository_model.dart';

class MockDatabaseManager extends Mock implements DatabaseManager {}

void main() {
  group(RepositoryCubit, () {
    late RepositoryCubit repositoryCubit;
    late MockDatabaseManager mockDatabaseManager;

    setUp(() {
      mockDatabaseManager = MockDatabaseManager();
      repositoryCubit = RepositoryCubit(mockDatabaseManager);
    });

    test("initial state is []", () {
      expect(repositoryCubit.state, equals([]));
    });

    test("Assert that init correctly fetches data from the database manager",
        () async {
      RepositoryModel model = RepositoryModel(
        id: 0,
        path: "test/Path",
        passwordFile: "test/passwordFile.txt",
        snapshotInterval: Duration(days: 7),
      );

      when(() => mockDatabaseManager.getRepositories())
          .thenAnswer((_) => Future.value([model]));

      await repositoryCubit.init();

      verify(() => mockDatabaseManager.getRepositories()).called(1);

      expect(repositoryCubit.state, [model]);
    });

    test("Assert that addRepository correctly adds a repo", () async {
      RepositoryModel model = RepositoryModel(
        path: "test/Path2",
        passwordFile: "test/PasswordFile.txt",
        snapshotInterval: Duration(days: 7),
        alias: "Test2",
      );
      RepositoryModel modelWithId = RepositoryModel(
        id: 1,
        path: model.path,
        passwordFile: model.passwordFile,
        snapshotInterval: model.snapshotInterval,
        alias: model.alias,
      );
      when(() => mockDatabaseManager.insertRepository(model))
          .thenAnswer((_) => Future.value(modelWithId));

      await repositoryCubit.addRepository(model);

      verify(() => mockDatabaseManager.insertRepository(model)).called(1);

      expect(repositoryCubit.state, [modelWithId]);
    });

    test("Assert that updateRepository correctly updates the repository",
        () async {
      RepositoryModel model = RepositoryModel(
        id: 0,
        path: "test/Path3",
        passwordFile: "test/PasswordFile.txt",
        snapshotInterval: Duration(days: 31),
      );

      // Prepare to be able to update model
      when(() => mockDatabaseManager.insertRepository(model))
          .thenAnswer((_) => Future.value(model));
      await repositoryCubit.addRepository(model);

      RepositoryModel updatedModel = RepositoryModel(
        id: 0,
        path: "test/Path4",
        passwordFile: "test/PasswordFile2.txt",
        snapshotInterval: Duration(days: 21),
        alias: "Updated",
      );

      when(() => mockDatabaseManager.updateRepository(updatedModel))
          .thenAnswer((_) => Future.value(null));

      await repositoryCubit.updateRepository(updatedModel);

      verify(() => mockDatabaseManager.updateRepository(updatedModel))
          .called(1);

      expect(repositoryCubit.state, [updatedModel]);
    });

    test("Assert that removeRepository correctly updates the repository",
        () async {
      RepositoryModel model = RepositoryModel(
        id: 0,
        path: "test/Path",
        passwordFile: "test/PasswordFile.txt",
        snapshotInterval: Duration(days: 31),
      );

      // Prepare to be able to delete model
      when(() => mockDatabaseManager.insertRepository(model))
          .thenAnswer((_) => Future.value(model));
      await repositoryCubit.addRepository(model);

      when(() => mockDatabaseManager.deleteRepository(model))
          .thenAnswer((_) => Future.value(null));

      await repositoryCubit.removeRepository(model);

      verify(() => mockDatabaseManager.deleteRepository(model)).called(1);

      expect(repositoryCubit.state, []);
    });
  });
}

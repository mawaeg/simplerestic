import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/common/models/snapshot_interval_options_enum.dart';
import 'package:simplerestic/create_repository/cubits/create_repository_cubit.dart';
import 'package:tuple/tuple.dart';

void main() {
  group(CreateRepositoryCubit, () {
    late CreateRepositoryCubit createRepositoryCubit;

    setUp(() {
      createRepositoryCubit = CreateRepositoryCubit();
    });

    void expectDefaultValues({
      bool checkPath = true,
      bool checkPasswordFile = true,
      bool checkAlias = true,
      bool checkSnapshotInterval = true,
      bool checkIsSuccessful = true,
    }) {
      if (checkPath) {
        expect(createRepositoryCubit.state.path, null);
      }
      if (checkPasswordFile) {
        expect(createRepositoryCubit.state.passwordFile, null);
      }
      if (checkAlias) {
        expect(createRepositoryCubit.state.alias, null);
      }
      if (checkSnapshotInterval) {
        expect(createRepositoryCubit.state.snapshotInterval, null);
      }
      if (checkIsSuccessful) {
        expect(createRepositoryCubit.state.isSuccessful, false);
      }
    }

    test("Assert that initial state is an empty CreateRepositoryModel", () {
      expectDefaultValues();
    });

    test("Assert that setPath correctly sets the path", () {
      createRepositoryCubit.setPath("test/Path");

      expect(createRepositoryCubit.state.path, "test/Path");
      expectDefaultValues(checkPath: false);
    });

    test("Assert that setPasswordFile correctly sets the password file", () {
      createRepositoryCubit.setPasswordFile("testPasswordFile");

      expect(createRepositoryCubit.state.passwordFile, "testPasswordFile");
      expectDefaultValues(checkPasswordFile: false);
    });

    test("Assert that setAlias correctly sets the alias", () {
      createRepositoryCubit.setAlias("testAlias");

      expect(createRepositoryCubit.state.alias, "testAlias");
      expectDefaultValues(checkAlias: false);
    });

    test("Assert that setInterval correctly sets the interval", () {
      Map<Duration, Tuple2<int, SnapshotIntervalOptionsEnum>> data = {
        Duration(hours: 1): Tuple2(1, SnapshotIntervalOptionsEnum.hours),
        Duration(days: 2): Tuple2(2, SnapshotIntervalOptionsEnum.days),
        Duration(days: 3 * 7): Tuple2(3, SnapshotIntervalOptionsEnum.weeks),
        Duration(days: 4 * 31): Tuple2(4, SnapshotIntervalOptionsEnum.months),
        Duration(days: 5 * 365): Tuple2(5, SnapshotIntervalOptionsEnum.years),
      };

      for (MapEntry<Duration, Tuple2<int, SnapshotIntervalOptionsEnum>> entry
          in data.entries) {
        createRepositoryCubit.setInterval(entry.value.item1, entry.value.item2);

        expect(createRepositoryCubit.state.snapshotInterval, entry.key);
        expectDefaultValues(checkSnapshotInterval: false);
      }
    });

    test("Assert that setIsSuccessful correctly sets the isSuccessful bool",
        () {
      createRepositoryCubit.setIsSuccessful(true);

      expect(createRepositoryCubit.state.isSuccessful, true);
      expectDefaultValues(checkIsSuccessful: false);
    });

    test("Assert that clear correctly clears all the data.", () {
      createRepositoryCubit.setPath("test/Path");
      createRepositoryCubit.setPasswordFile("testPasswordFile");
      createRepositoryCubit.setAlias("testAlias");
      createRepositoryCubit.setInterval(1, SnapshotIntervalOptionsEnum.days);
      createRepositoryCubit.setIsSuccessful(true);

      createRepositoryCubit.clear();

      expectDefaultValues();
    });
  });
}

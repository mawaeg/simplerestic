import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/common/cubits/snapshot_rebuild_cubit.dart';

void main() {
  group(SnapshotRebuildCubit, () {
    late SnapshotRebuildCubit snapshotRebuildCubit;

    setUp(() {
      snapshotRebuildCubit = SnapshotRebuildCubit();
    });

    test("initial state is `false`", () {
      expect(snapshotRebuildCubit.state, equals(false));
    });

    test("Assert that toggle correctly toggles the state", () {
      bool initialState = snapshotRebuildCubit.state;
      snapshotRebuildCubit.toggle();
      expect(snapshotRebuildCubit.state, equals(!initialState));
      snapshotRebuildCubit.toggle();
      expect(snapshotRebuildCubit.state, equals(initialState));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_summary_type.dart';
import 'package:simplerestic/common/cubits/snapshots_list_cubit.dart';

void main() {
  group(SnapshotsListCubit, () {
    late SnapshotsListCubit snapshotsListCubit;

    setUp(() {
      snapshotsListCubit = SnapshotsListCubit();
    });

    test("initial state is `false`", () {
      expect(snapshotsListCubit.state, []);
    });

    test(
        "Assert that setSnapshots and removeSnapshots correctly update the state",
        () {
      List<ResticSnapshotsObjectType> snapshots = [
        ResticSnapshotsObjectType(
          DateTime(2025),
          "testParent",
          "testTree",
          ["testPath"],
          "testHostname",
          "testUser",
          123,
          1234,
          "testVersion",
          ResticSnapshotsSummaryType(
            DateTime(2025),
            DateTime(2025),
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
          ),
          "testId",
          "testShortId",
        )
      ];

      snapshotsListCubit.setSnapshots(snapshots);
      expect(snapshotsListCubit.state, snapshots);

      snapshotsListCubit.removeSnapshot(snapshots.first.id);
      expect(snapshotsListCubit.state, []);
    });
  });
}

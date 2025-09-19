import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command.dart';
import 'package:simplerestic/backend/restic_command_executor.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_grouped_snapshot_key_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_grouped_snapshots_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_summary_type.dart';
import 'package:simplerestic/detail_repository/utils/create_snapshot_list_model.dart';

class ResticCommandExecutorMock extends Mock implements ResticCommandExecutor {}

class ResticCommandFake extends Fake implements ResticCommand {}

void main() {
  setUpAll(() {
    registerFallbackValue(ResticCommandFake());
  });

  test(
      "Assert that SnapshotListModelCreator().create() sorts snapshots per keys ordered by time as expected",
      () async {
    final ResticCommandExecutorMock commandExecutorMock =
        ResticCommandExecutorMock();

    // Create fake data which should be sorted by the create function
    ResticSnapshotsSummaryType summary = ResticSnapshotsSummaryType(
      DateTime.parse("2023-10-01T10:00:00Z"),
      DateTime.parse("2023-10-01T11:00:00Z"),
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      900,
      1000,
      1100,
      1200,
    );

    ResticGroupedSnapshotsType unsorted = ResticGroupedSnapshotsType({
      const ResticGroupedSnapshotKeyType(
          hostname: "host1", paths: ["/path1"], tags: null): [
        ResticSnapshotsObjectType(
          DateTime.parse("2000-01-01T10:00:00Z"),
          null,
          "testTree",
          ["/path1"],
          "testHostname",
          "testUsername",
          1000,
          1000,
          "testProgramVersion",
          summary,
          "testId",
          "testShortId",
        ),
      ],
      const ResticGroupedSnapshotKeyType(
          hostname: "host1", paths: ["/path2"], tags: null): [
        ResticSnapshotsObjectType(
          DateTime.parse("2000-01-02T10:00:00Z"),
          null,
          "testTree",
          ["/path1"],
          "testHostname",
          "testUsername",
          1000,
          1000,
          "testProgramVersion",
          summary,
          "testId",
          "testShortId",
        ),
      ],
      const ResticGroupedSnapshotKeyType(
          hostname: "host1", paths: ["/path3"], tags: null): [
        ResticSnapshotsObjectType(
          DateTime.parse("1999-01-02T10:00:00Z"),
          null,
          "testTree",
          ["/path1"],
          "testHostname",
          "testUsername",
          1000,
          1000,
          "testProgramVersion",
          summary,
          "testId",
          "testShortId",
        ),
      ],
    });

    // Setup mocks to return the unsorted data
    when(() => commandExecutorMock.executeCommandAsync(any()))
        .thenAnswer((invocation) async => [unsorted]);

    ResticGroupedSnapshotsType sorted =
        await SnapshotListModelCreator(commandExecutor: commandExecutorMock)
            .create("testPath", "testPasswordFile");

    // The unsorted list has the following order:
    // key1 -> 2000-01-01
    // key2 -> 2000-01-02
    // key3 -> 1999-01-02

    // The sorted list should have the following order:
    // key3 -> 1999-01-02
    // key1 -> 2000-01-01
    // key2 -> 2000-01-02
    expect(
      sorted.snapshots.keys.toList()[0],
      unsorted.snapshots.keys.toList()[2],
    );
    expect(
      sorted.snapshots.keys.toList()[1],
      unsorted.snapshots.keys.toList()[0],
    );
    expect(
      sorted.snapshots.keys.toList()[2],
      unsorted.snapshots.keys.toList()[1],
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_summary_type.dart';
import 'package:simplerestic/common/models/repository_model.dart';
import 'package:simplerestic/common/utils/abstraction_layer.dart';
import 'package:simplerestic/detail_repository/utils/is_backup_needed.dart';

class DateTimeUtilityMock extends Mock implements DateTimeUtility {}

ResticSnapshotsObjectType createSnapshotObjectWithTime(DateTime time) {
  return ResticSnapshotsObjectType(
    time,
    "testParent",
    "testTree",
    ["testPaths"],
    "testHostname",
    "testUsername",
    0,
    1,
    "testProgramVersion",
    ResticSnapshotsSummaryType(
      DateTime.now(),
      DateTime.now(),
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
    ),
    "testId",
    "testShortId",
  );
}

RepositoryModel createRepositoryModelWithDuration(Duration duration) {
  return RepositoryModel(
    path: "testPath",
    passwordFile: "testPasswordFile",
    snapshotInterval: duration,
  );
}

void main() {
  group("Assert that isBackupNeeded works as expected", () {
    late DateTimeUtilityMock dateTimeUtilityMock;

    setUp(() {
      dateTimeUtilityMock = DateTimeUtilityMock();
    });

    test("and returns false when snapshotInterval is 0", () {
      final repository = createRepositoryModelWithDuration(Duration.zero);
      final snapshot = createSnapshotObjectWithTime(DateTime.now());

      final result = isBackupNeeded(
        repository,
        snapshot,
      );

      expect(result, isFalse);
    });

    test(
        "and returns false when the snapshot is newer then the snapshot interval mandates",
        () {
      final repository = createRepositoryModelWithDuration(Duration(days: 7));
      final snapshot = createSnapshotObjectWithTime(
          DateTime.now().subtract(Duration(days: 3)));

      final result = isBackupNeeded(
        repository,
        snapshot,
      );

      expect(result, isFalse);
    });

    test(
        "and returns true when the snapshot is older then the snapshot interval mandates",
        () {
      final repository = createRepositoryModelWithDuration(Duration(days: 7));
      final snapshot = createSnapshotObjectWithTime(
        DateTime.now().subtract(Duration(days: 8)),
      );

      final result = isBackupNeeded(
        repository,
        snapshot,
      );

      expect(result, isTrue);
    });

    test(
        "and returns true when the snapshot is equally to what the snapshot interval mandates",
        () {
      final DateTime dateTime = DateTime.now();
      final repository = createRepositoryModelWithDuration(Duration(days: 7));
      final snapshot = createSnapshotObjectWithTime(
        dateTime.subtract(Duration(days: 7)),
      );

      when(() => dateTimeUtilityMock.getDateTimeNow()).thenReturn(dateTime);

      final result = isBackupNeeded(
        repository,
        snapshot,
        dateTimeUtility: dateTimeUtilityMock,
      );

      expect(result, isTrue);
    });
  });
}

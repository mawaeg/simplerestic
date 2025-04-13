import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_snapshots.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_summary_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/snapshots/restic_snapshots_type.dart';

void main() {
  ResticCommandSnapshots resticCommand = ResticCommandSnapshots(
      repository: "testRepo", passwordFile: "testPassword");
  group(
      "Check that ResticCommandSnapshots builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandSnapshots correctly builds a command.", () {
      expect(resticCommand.build(), [
        "snapshots",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
      ]);
    });
    test("Ensure ResticCommandSnapshots correctly parses Json", () {
      // 2025-04-12T19:42:54.499Z
      List json = [
        {
          "time": "2000-01-01T00:00:00.000Z",
          "parent": "testParent",
          "tree": "testTree",
          "paths": ["testPath1", "testPath2"],
          "hostname": "testHostname",
          "username": "testUsername",
          "uid": 1,
          "gid": 2,
          "program_version": "testProgramVersion",
          "summary": {
            "backup_start": "2111-11-11T11:11:11.111Z",
            "backup_end": "2222-22-22T22:22:22.222Z",
            "files_new": 1,
            "files_changed": 2,
            "files_unmodified": 3,
            "dirs_new": 4,
            "dirs_changed": 5,
            "dirs_unmodified": 6,
            "data_blobs": 7,
            "tree_blobs": 8,
            "data_added": 9,
            "data_added_packed": 10,
            "total_files_processed": 11,
            "total_bytes_processed": 12,
          },
          "id": "testId",
          "short_id": "testShortId",
        },
        {
          "time": "2333-03-03T03:03:03.003Z",
          "tree": "testTree2",
          "paths": ["testPath3", "testPath4"],
          "hostname": "testHostname2",
          "username": "testUsername2",
          "uid": 3,
          "gid": 4,
          "program_version": "testProgramVersion2",
          "summary": {
            "backup_start": "2444-04-04T04:04:04.004Z",
            "backup_end": "2555-05-05T05:05:05.005Z",
            "files_new": 13,
            "files_changed": 14,
            "files_unmodified": 15,
            "dirs_new": 16,
            "dirs_changed": 17,
            "dirs_unmodified": 18,
            "data_blobs": 19,
            "tree_blobs": 20,
            "data_added": 21,
            "data_added_packed": 22,
            "total_files_processed": 23,
            "total_bytes_processed": 24,
          },
          "id": "testId2",
          "short_id": "testShortId2",
        }
      ];
      expect(
        resticCommand.parseJson(json),
        ResticSnapshotsType([
          ResticSnapshotsObjectType(
            DateTime.parse("2000-01-01T00:00:00.000Z"),
            "testParent",
            "testTree",
            ["testPath1", "testPath2"],
            "testHostname",
            "testUsername",
            1,
            2,
            "testProgramVersion",
            ResticSnapshotsSummaryType(
              DateTime.parse("2111-11-11T11:11:11.111Z"),
              DateTime.parse("2222-22-22T22:22:22.222Z"),
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
          ),
          ResticSnapshotsObjectType(
            DateTime.parse("2333-03-03T03:03:03.003Z"),
            null,
            "testTree2",
            ["testPath3", "testPath4"],
            "testHostname2",
            "testUsername2",
            3,
            4,
            "testProgramVersion2",
            ResticSnapshotsSummaryType(
              DateTime.parse("2444-04-04T04:04:04.004Z"),
              DateTime.parse("2555-05-05T05:05:05.005Z"),
              13,
              14,
              15,
              16,
              17,
              18,
              19,
              20,
              21,
              22,
              23,
              24,
            ),
            "testId2",
            "testShortId2",
          )
        ]),
      );

      expect(resticCommand.parseJson({"test"}), null);
    });
  });
}

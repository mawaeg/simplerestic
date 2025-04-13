import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_backup.dart';
import 'package:simplerestic/backend/restic_types/primitives/backup/restic_backup_error_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/backup/restic_backup_status_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/backup/restic_backup_summary_type.dart';

void main() {
  ResticCommandBackup resticCommand = ResticCommandBackup(
    repository: "testRepo",
    passwordFile: "testPassword",
    path: "testPath",
  );
  group(
      "Check that ResticCommandBackup builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandBackup correctly builds a command.", () {
      expect(resticCommand.build(), [
        "backup",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "testPath"
      ]);
    });
    test("Ensure ResticCommandInit correctly parses Json", () {
      Map<String, dynamic> statusJson = {
        "message_type": "status",
        "seconds_elapsed": 1,
        "seconds_remaining": 2,
        "percent_done": 0.3,
        "total_files": 4,
        "files_done": 5,
        "total_bytes": 6,
        "bytes_done": 7,
        "error_count": 8,
        "current_files": ["file1", "file2"],
      };
      ResticBackupStatusType? statusType =
          resticCommand.parseJson(statusJson) as ResticBackupStatusType?;
      expect(
        statusType,
        ResticBackupStatusType(1, 2, 0.3, 4, 5, 6, 7, 8, ["file1", "file2"]),
      );

      expect(statusType!.progress, 30.0);

      Map<String, dynamic> statusOnlyRequiredJson = {
        "message_type": "status",
        "percent_done": 0.3,
        "total_files": 4,
        "total_bytes": 6,
      };
      expect(
        resticCommand.parseJson(statusOnlyRequiredJson),
        ResticBackupStatusType(0, null, 0.3, 4, null, 6, null, null, null),
      );

      Map<String, dynamic> summaryJson = {
        "message_type": "summary",
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
        "total_duration": 13.0,
        "snapshot_id": "testSnapshotId"
      };
      expect(
        resticCommand.parseJson(summaryJson),
        ResticBackupSummaryType(
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13.0, "testSnapshotId"),
      );

      Map<String, dynamic> errorJson = {
        "message_type": "error",
        "error_message": "testErrorMessage",
        "during": "testDuring",
        "item": "testItem",
      };
      expect(
        resticCommand.parseJson(errorJson),
        ResticBackupErrorType("testErrorMessage", "testDuring", "testItem"),
      );

      Map<String, dynamic> invalidJson = {"message_type": "not_initialized"};
      expect(resticCommand.parseJson(invalidJson), null);
    });
  });
}

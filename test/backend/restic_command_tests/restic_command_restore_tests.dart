import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_restore.dart';
import 'package:simplerestic/backend/restic_types/base/restic_json_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/base/restic_base_error_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/restore/restic_restore_status_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/restore/restic_restore_summary_type.dart';

void main() {
  //ToDo also test with path
  ResticCommandRestore resticCommand = ResticCommandRestore(
    repository: "testRepo",
    passwordFile: "testPassword",
    target: "test/testTarget",
    snapshotId: "testSnapshotId",
  );
  group(
      "Check that ResticCommandRestore builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandRestore correctly builds a basic command.", () {
      expect(resticCommand.build(), [
        "restore",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "--target",
        "test/testTarget",
        "--overwrite",
        "always",
        "testSnapshotId",
      ]);
    });
    test("Ensure ResticCommandRestore correctly builds a complete command.",
        () {
      ResticCommandRestore advancedResticCommand = ResticCommandRestore(
        repository: resticCommand.repository,
        passwordFile: resticCommand.passwordFile,
        target: "test/testTarget",
        snapshotId: "testSnapshotId",
        path: "test/testPath",
        delete: true,
      );
      expect(advancedResticCommand.build(), [
        "restore",
        "--json",
        "--delete",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "--target",
        "test/testTarget",
        "--overwrite",
        "always",
        "testSnapshotId:test/testPath",
      ]);
    });
    test(
        "Ensure ResticCommandRestore correctly parses minimal status message type Json",
        () {
      Map<String, dynamic> json = {
        "message_type": "status",
        "percent_done": 0.11,
        "total_files": 21,
      };
      ResticRestoreStatusType? statusType =
          resticCommand.parseJson(json) as ResticRestoreStatusType;
      expect(
        statusType,
        ResticRestoreStatusType(
            0, 0.11, 21, null, null, null, null, null, null),
      );

      expect(statusType.progress, 11.0);
    });
    test(
        "Ensure ResticCommandRestore correctly parses a minimal summary message type Json",
        () {
      Map<String, dynamic> json = {
        "message_type": "summary",
        "total_files": 12,
        "files_restored": 34,
      };
      expect(
        resticCommand.parseJson(json),
        ResticRestoreSummaryType(0, 12, 34, null, null, null, null, null),
      );
    });
    test(
        "Ensure ResticCommandRestore correclty parses a full summary message type Json",
        () {
      Map<String, dynamic> json = {
        "message_type": "summary",
        "seconds_elapsed": 12,
        "total_files": 34,
        "files_restored": 56,
        "files_skipped": 78,
        "files_deleted": 90,
        "total_bytes": 21,
        "bytes_restored": 43,
        "bytes_skipped": 65,
      };
      expect(
        resticCommand.parseJson(json),
        ResticRestoreSummaryType(12, 34, 56, 78, 90, 21, 43, 65),
      );
    });
    test(
        "Ensure ResticCommandRestore correctly parses a full error message type Json",
        () {
      Map<String, dynamic> json = {
        "message_type": "error",
        "error_message": "Test Error Message",
        "during": "restore",
        "item": "testItem",
      };
      expect(
        resticCommand.parseJson(json),
        ResticBaseErrorType("Test Error Message", "restore", "testItem"),
      );
    });
    test(
        "Ensure ResticCommandRestore correctly parses invalid message type Json",
        () {
      Map<String, dynamic> json = {
        "message_type": "invalid_message_type",
      };
      expect(
        resticCommand.parseJson(json),
        null,
      );
    });
  });
}

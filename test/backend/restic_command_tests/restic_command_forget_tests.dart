import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_forget.dart';

void main() {
  ResticCommandForget resticCommand = ResticCommandForget(
    repository: "testRepo",
    passwordFile: "testPassword",
    snapshotId: "snapshotId1234",
  );
  group(
      "Check that ResticCommandForget builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandForget correctly builds a basic command.", () {
      expect(resticCommand.build(), [
        "forget",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "snapshotId1234",
      ]);
    });
    test("Ensure ResticCommandForget correctly builds a complete command.", () {
      ResticCommandForget advancedResticCommand = ResticCommandForget(
        repository: "testRepo",
        passwordFile: "testPassword",
        snapshotId: "snapshotId1234",
        prune: true,
      );
      expect(advancedResticCommand.build(), [
        "forget",
        "--json",
        "--prune",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "snapshotId1234",
      ]);
    });
    test("Ensure ResticCommandForget correctly parses Json", () {
      Map<String, dynamic> json = {
        "any_key": "any_value",
      };
      expect(
        resticCommand.parseJson(json),
        null,
      );
    });
  });
}

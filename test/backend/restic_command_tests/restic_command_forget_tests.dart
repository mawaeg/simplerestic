import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_forget.dart';

void main() {
  // ToDo Split in two tests
  ResticCommandForget resticCommand = ResticCommandForget(
    repository: "testRepo",
    passwordFile: "testPassword",
    snapshotId: "snapshotId1234",
    prune: true,
  );
  ResticCommandForget onlyNeededResticCommand = ResticCommandForget(
    repository: resticCommand.repository,
    passwordFile: resticCommand.passwordFile,
    snapshotId: resticCommand.snapshotId,
  );
  List<String> expectedMinimal = [
    "forget",
    "--json",
    "--repo",
    "testRepo",
    "--password-file",
    "testPassword",
    "snapshotId1234",
  ];
  List<String> expected = List.from(expectedMinimal);
  expected.insert(2, "--prune");
  group(
      "Check that ResticCommandForget builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandForget correctly builds a command.", () {
      expect(resticCommand.build(), expected);
      expect(onlyNeededResticCommand.build(), expectedMinimal);
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

import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_init.dart';
import 'package:simplerestic/backend/restic_types/primitives/init/restic_init_type.dart';

void main() {
  ResticCommandInit resticCommand =
      ResticCommandInit(repository: "testRepo", passwordFile: "testPassword");
  group(
      "Check that ResticCommandInit builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandInit correctly builds a command.", () {
      expect(resticCommand.build(), [
        "init",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
      ]);
    });
    test("Ensure ResticCommandInit correctly parses Json", () {
      Map<String, dynamic> json = {
        "message_type": "initialized",
        "id": "testId",
        "repository": "testRepository"
      };
      expect(
        resticCommand.parseJson(json),
        ResticInitType("testId", "testRepository"),
      );

      Map<String, dynamic> invalidJson = {"message_type": "not_initialized"};
      expect(resticCommand.parseJson(invalidJson), null);
    });
  });
}

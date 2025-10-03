import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_check.dart';
import 'package:simplerestic/backend/restic_types/primitives/check/restic_check_summary_type.dart';

void main() {
  ResticCommandCheck resticCommand =
      ResticCommandCheck(repository: "testRepo", passwordFile: "testPassword");
  group(
      "Check that ResticCommandCheck builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandCheck correctly builds a command.", () {
      expect(resticCommand.build(), [
        "check",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
      ]);
    });
    test("Ensure ResticCommandCheck correctly parses Json", () {
      Map<String, dynamic> json = {
        "message_type": "summary",
        "num_errors": 0,
        "broken_packs": ["pack1", "pack2", "pack3"],
        "suggest_repair_index": true,
        "suggest_prune": false,
      };
      expect(
        resticCommand.parseJson(json),
        ResticCheckSummaryType(0, ["pack1", "pack2", "pack3"], true, false),
      );
    });

    test("Ensure ResticCommandCheck correctly parses with invalid message type",
        () {
      Map<String, dynamic> json = {
        "message_type": "not_summary",
      };
      expect(
        resticCommand.parseJson(json),
        null,
      );
    });
  });
}

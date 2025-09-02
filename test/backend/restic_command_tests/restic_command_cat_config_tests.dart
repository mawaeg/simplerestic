import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_cat_config.dart';
import 'package:simplerestic/backend/restic_types/primitives/cat_config/restic_cat_config_type.dart';

void main() {
  ResticCommandCatConfig resticCommand = ResticCommandCatConfig(
      repository: "testRepo", passwordFile: "testPassword");
  group(
      "Check that ResticCommandCatConfig builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandCatConfig correctly builds a command.", () {
      expect(resticCommand.build(), [
        "cat",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "config",
      ]);
    });
    test("Ensure ResticCommandCatConfig correctly parses Json", () {
      Map<String, dynamic> json = {
        "version": 10,
        "id": "qwertasdf1234",
        "chunker_polynomial": "1234asdfqwert",
      };
      expect(
        resticCommand.parseJson(json),
        ResticCatConfigType(10, "qwertasdf1234", "1234asdfqwert"),
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_mount.dart';

void main() {
  ResticCommandMount resticCommand = ResticCommandMount(
    repository: "testRepo",
    passwordFile: "testPassword",
    mountPoint: "test/mountpoint",
  );
  group(
      "Check that ResticCommandMount builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandMount correctly builds a basic command.", () {
      expect(resticCommand.build(), [
        "mount",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "test/mountpoint"
      ]);
    });
    test("Ensure ResticCommandMount correctly builds a complete command.", () {
      ResticCommandMount advancedResticCommand = ResticCommandMount(
        repository: resticCommand.repository,
        passwordFile: resticCommand.passwordFile,
        mountPoint: resticCommand.mountPoint,
        path: "test/testPath",
      );
      expect(advancedResticCommand.build(), [
        "mount",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "--path",
        "test/testPath",
        "test/mountpoint",
      ]);
    });
    test("Ensure ResticCommandMount correctly parses Json", () {
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

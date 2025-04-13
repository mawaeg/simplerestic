import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_cli.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_flag_type.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_option_type.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_options.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_type.dart';
import 'package:simplerestic/backend/restic_types/base/restic_json_type.dart';

//Impl needed to test abstract class.
class ResticCommandTestImpl extends ResticCommandCli {
  ResticCommandTestImpl({
    required super.type,
    required super.repository,
    required super.passwordFile,
    super.flags,
    super.options,
    super.args,
  });

  @override
  ResticJsonType? parseJson(dynamic json) => null;
}

void main() {
  group("Check that ResticCommandCli builds commands as expected", () {
    test(
        "Ensure ResticCommand correctly builds a command without any extra flags, options and args expect for the default ones.",
        () {
      ResticCommandTestImpl resticCommand = ResticCommandTestImpl(
          type: ResticCommandType.init,
          repository: "testRepo",
          passwordFile: "testPassword");

      expect(resticCommand.build(), [
        "init",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
      ]);
    });
    test(
        "Ensure ResticCommand correctly builds a command with extra flags, options, args provided..",
        () {
      ResticCommandTestImpl resticCommand = ResticCommandTestImpl(
        type: ResticCommandType.init,
        repository: "testRepo",
        passwordFile: "testPassword",
        flags: [ResticCommandFlagType.quiet],
        //No more options currently -> second repo
        options: [
          ResticCommandOption(ResticCommandOptionType.repo, "testRepo2")
        ],
        args: ["testArg"],
      );

      expect(resticCommand.build(), [
        "init",
        "--json",
        "--quiet",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "--repo",
        "testRepo2",
        "testArg"
      ]);
    });
  });
}

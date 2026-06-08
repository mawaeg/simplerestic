import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_flag_type.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_option_type.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_options.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_type.dart';
import 'package:simplerestic/backend/restic_types/base/restic_json_type.dart';

//Impl needed to test abstract class.
class ResticCommandTestImpl extends ResticCommand {
  const ResticCommandTestImpl({
    required super.type,
    super.commandFlags,
    super.commandOptions,
    super.commandArgs,
  });

  @override
  ResticJsonType? parseJson(dynamic json) => null;
}

void main() {
  group("Check that ResticCommand builds commands as expected", () {
    test(
        "Ensure ResticCommand correctly builds a command without any flags, options and args.",
        () {
      ResticCommandTestImpl resticCommand = ResticCommandTestImpl(
        type: ResticCommandType.init,
      );

      expect(resticCommand.build(), ["init"]);
    });
    test(
        "Ensure ResticResticCommand correctly builds a command with one flag, option and arg.",
        () {
      ResticCommandTestImpl resticCommand = ResticCommandTestImpl(
        type: ResticCommandType.init,
        commandFlags: [ResticCommandFlagType.json],
        commandOptions: [
          ResticCommandOption(ResticCommandOptionType.repo, "testRepo")
        ],
        commandArgs: ["testArg"],
      );

      List<String> expected = [
        "init",
        "--json",
        "--repo",
        "testRepo",
        "testArg",
      ];

      expect(resticCommand.build(), expected);
    });
    test(
        "Ensure ResticResticCommand correctly builds a command with two flags, options and args.",
        () {
      ResticCommandTestImpl resticCommand = ResticCommandTestImpl(
        type: ResticCommandType.init,
        commandFlags: [ResticCommandFlagType.json, ResticCommandFlagType.quiet],
        commandOptions: [
          ResticCommandOption(ResticCommandOptionType.repo, "testRepo"),
          ResticCommandOption(
            ResticCommandOptionType.password_file,
            "testPassword",
          ),
        ],
        commandArgs: ["testArg", "testArg2"],
      );

      List<String> expected = [
        "init",
        "--json",
        "--quiet",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
        "testArg",
        "testArg2",
      ];

      expect(resticCommand.build(), expected);
    });
  });
}

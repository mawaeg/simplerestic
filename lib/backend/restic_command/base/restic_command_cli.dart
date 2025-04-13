import 'restic_command.dart';
import 'restic_command_flag_type.dart';
import 'restic_command_option_type.dart';
import 'restic_command_options.dart';

/// A special [ResticCommand] which is prepared to be used with Scripting usage.
///
/// The class already adds the [ResticCommandFlagType.json] flag by default.
/// It also handles the addition of the repository and the password file by just taking the Strings as constructor input.
abstract class ResticCommandCli extends ResticCommand {
  static const List<ResticCommandFlagType> defaultFlags = [
    ResticCommandFlagType.json
  ];
  final String repository;
  final String passwordFile;
  final List<ResticCommandFlagType>? flags;
  final List<ResticCommandOption>? options;
  final List<String>? args;

  ResticCommandCli({
    required super.type,
    required this.repository,
    required this.passwordFile,
    this.flags,
    this.options,
    this.args,
  }) : super(
          flags: defaultFlags + (flags ?? []),
          options: [
                ResticCommandOption(
                  ResticCommandOptionType.repo,
                  repository,
                ),
                ResticCommandOption(
                  ResticCommandOptionType.password_file,
                  passwordFile,
                ),
              ] +
              (options ?? []),
          args: args,
        );
}

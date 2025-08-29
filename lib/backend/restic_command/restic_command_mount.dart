import '../restic_types/base/restic_json_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_option_type.dart';
import 'base/restic_command_options.dart';
import 'base/restic_command_type.dart';

class ResticCommandMount extends ResticCommandCli {
  /// The mount point where the repository should be served
  final String mountPoint;

  /// An optional path which should be considered only
  final String? path;

  ResticCommandMount(
      {required super.repository,
      required super.passwordFile,
      required this.mountPoint,
      this.path})
      : super(
          type: ResticCommandType.mount,
          args: [mountPoint],
          options: path != null
              ? [ResticCommandOption(ResticCommandOptionType.path, path)]
              : null,
        );

  @override
  ResticJsonType? parseJson(json) {
    // Command does not support json
    return null;
  }
}

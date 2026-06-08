import 'package:equatable/equatable.dart';

import '../../restic_types/base/restic_json_type.dart';
import '../../utils/normalize_enum_name.dart';
import 'restic_command_flag_type.dart';
import 'restic_command_options.dart';
import 'restic_command_type.dart';

/// Represents a command that can be executed with restic
abstract class ResticCommand extends Equatable {
  final ResticCommandType type;
  final List<ResticCommandFlagType> commandFlags;
  final List<ResticCommandOption> commandOptions;
  final List<String> commandArgs;

  const ResticCommand({
    required this.type,
    this.commandFlags = const [],
    this.commandOptions = const [],
    this.commandArgs = const [],
  });

  /// Builds the command to a [List] with all flags, options and args
  List<String> build() {
    List<String> commandList = [];
    commandList.add(type.name);
    for (var element in commandFlags) {
      commandList.add(normalizeCommandEnum(element.name));
    }
    for (var element in commandOptions) {
      commandList.addAll(element.build());
    }
    commandList.addAll(commandArgs);

    return commandList;
  }

  /// Parses the json output given by stdout to a [ResticJsonType].
  ResticJsonType? parseJson(dynamic json);

  // Intentionally leave out the flags, as they only change the way a specific command gets executed
  // i.E. Dry Run, or verbose.
  // However they are still the "same" command
  @override
  List<Object?> get props => [type, commandOptions, commandArgs];
}

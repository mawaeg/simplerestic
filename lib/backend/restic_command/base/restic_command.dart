import 'package:simplerestic/backend/utils/normalize_enum_name.dart';

import '../../restic_types/base/restic_json_type.dart';
import 'restic_command_flag_type.dart';
import 'restic_command_options.dart';
import 'restic_command_type.dart';

/// Represents a command that can be executed with restic
abstract class ResticCommand {
  final ResticCommandType type;
  late List<ResticCommandFlagType> _flags;
  late List<ResticCommandOption> _options;
  late List<String> _args;

  ResticCommand({
    required this.type,
    List<ResticCommandFlagType>? flags,
    List<ResticCommandOption>? options,
    List<String>? args,
  }) {
    _flags = flags ?? [];
    _options = options ?? [];
    _args = args ?? [];
  }

  /// Builds the command to a [List] with all flags, options and args
  List<String> build() {
    List<String> options = [];
    options.add(type.name);
    for (var element in _flags) {
      options.add(normalizeCommandEnum(element.name));
    }
    for (var element in _options) {
      options.addAll(element.build());
    }
    options.addAll(_args);

    return options;
  }

  /// Parses the json output given by stdout to a [ResticJsonType].
  ResticJsonType? parseJson(dynamic json);
}

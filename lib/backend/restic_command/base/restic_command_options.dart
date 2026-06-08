import 'package:equatable/equatable.dart';

import '../../utils/normalize_enum_name.dart';
import 'restic_command_option_type.dart';

class ResticCommandOption extends Equatable {
  final ResticCommandOptionType type;
  final String value;

  const ResticCommandOption(this.type, this.value);

  List<String> build() {
    return [normalizeCommandEnum(type.name), value];
  }

  @override
  List<Object?> get props => [type, value];
}

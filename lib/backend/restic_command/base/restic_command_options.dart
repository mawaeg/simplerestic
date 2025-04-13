import '../../utils/normalize_enum_name.dart';
import 'restic_command_option_type.dart';

class ResticCommandOption {
  final ResticCommandOptionType type;
  final String value;

  ResticCommandOption(this.type, this.value);

  List<String> build() {
    return [normalizeCommandEnum(type.name), value];
  }
}

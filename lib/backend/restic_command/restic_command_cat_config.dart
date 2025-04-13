import '../restic_types/base/restic_json_type.dart';
import '../restic_types/primitives/cat_config/restic_cat_config_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_type.dart';

class ResticCommandCatConfig extends ResticCommandCli {
  ResticCommandCatConfig({
    required super.repository,
    required super.passwordFile,
  }) : super(type: ResticCommandType.cat, args: ["config"]);

  @override
  ResticJsonType? parseJson(dynamic json) {
    return ResticCatConfigType.fromJson(json);
  }
}

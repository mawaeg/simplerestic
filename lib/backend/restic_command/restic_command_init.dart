import '../restic_types/base/restic_json_type.dart';
import '../restic_types/primitives/init/restic_init_type.dart';
import 'base/restic_command_cli.dart';
import 'base/restic_command_type.dart';

class ResticCommandInit extends ResticCommandCli {
  ResticCommandInit({
    required super.repository,
    required super.passwordFile,
  }) : super(type: ResticCommandType.init);

  @override
  ResticJsonType? parseJson(dynamic json) {
    switch (json["message_type"]) {
      case "initialized":
        return ResticInitType.fromJson(json);
      default:
        return null;
    }
  }
}

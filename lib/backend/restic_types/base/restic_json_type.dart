import 'restic_scripting_base_type.dart';

abstract class ResticJsonType extends ResticScriptingBaseType {
  ResticJsonType();

  factory ResticJsonType.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

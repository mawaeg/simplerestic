import 'base/restic_scripting_base_type.dart';

class ResticReturnType extends ResticScriptingBaseType {
  final int exitCode;
  ResticReturnType(this.exitCode);

  @override
  List<Object?> get props => [exitCode];
}

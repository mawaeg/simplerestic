import 'base/restic_scripting_base_type.dart';

class ResticErrorType extends ResticScriptingBaseType {
  final String error;
  ResticErrorType(this.error);

  @override
  List<Object?> get props => [error];
}

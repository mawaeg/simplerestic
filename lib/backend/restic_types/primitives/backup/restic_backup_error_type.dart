import '../../base/restic_json_type.dart';

/// Represents the json output for the backup command of message_type `error`.
class ResticBackupErrorType extends ResticJsonType {
  final String errorMessage;
  final String during;
  final String item;

  ResticBackupErrorType(this.errorMessage, this.during, this.item);

  factory ResticBackupErrorType.fromJson(dynamic json) => ResticBackupErrorType(
        json["error_message"],
        json["during"],
        json["item"],
      );

  @override
  List<Object?> get props => [
        errorMessage,
        during,
        item,
      ];
}

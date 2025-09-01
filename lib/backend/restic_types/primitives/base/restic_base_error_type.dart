import '../../base/restic_json_type.dart';

/// Represents the json output for the backup command of message_type `error`.
class ResticBaseErrorType extends ResticJsonType {
  final String errorMessage;
  final String during;
  final String item;

  ResticBaseErrorType(this.errorMessage, this.during, this.item);

  factory ResticBaseErrorType.fromJson(dynamic json) => ResticBaseErrorType(
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

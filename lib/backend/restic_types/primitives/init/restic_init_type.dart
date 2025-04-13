import '../../base/restic_json_type.dart';

/// Represents the json output for the init command of message_type `init`.
class ResticInitType extends ResticJsonType {
  final String id;
  final String repository;

  ResticInitType(this.id, this.repository);

  factory ResticInitType.fromJson(dynamic json) => ResticInitType(
        json["id"],
        json["repository"],
      );

  @override
  List<Object?> get props => [
        id,
        repository,
      ];
}

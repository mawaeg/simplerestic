import '../../base/restic_json_type.dart';

/// Represents the json output for the backup command of message_type `status`.
class ResticRestoreStatusType extends ResticJsonType {
  final int secondsElapsed;
  final double percentDone;
  final int totalFiles;
  final int? filesRestored;
  final int filesSkipped;
  final int? filesDeleted;
  final int? totalBytes;
  final int? bytesRestored;
  final int? bytesSkipped;

  ResticRestoreStatusType(
    this.secondsElapsed,
    this.percentDone,
    this.totalFiles,
    this.filesRestored,
    this.filesSkipped,
    this.filesDeleted,
    this.totalBytes,
    this.bytesRestored,
    this.bytesSkipped,
  );

  double get progress => double.parse((percentDone * 100).toStringAsFixed(1));

  factory ResticRestoreStatusType.fromJson(dynamic json) =>
      ResticRestoreStatusType(
        json["seconds_elapsed"] ?? 0,
        double.parse(json["percent_done"].toString()),
        json["total_files"],
        json["files_restored"],
        json["files_skipped"],
        json["files_deleted"],
        json["total_bytes"],
        json["bytes_restored"],
        json["bytes_skipped"],
      );

  @override
  List<Object?> get props => [
        secondsElapsed,
        percentDone,
        totalFiles,
        filesRestored,
        filesSkipped,
        filesDeleted,
        totalBytes,
        bytesRestored,
        bytesSkipped,
      ];
}

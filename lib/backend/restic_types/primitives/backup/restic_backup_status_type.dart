import '../../base/restic_json_type.dart';

/// Represents the json output for the backup command of message_type `status`.
class ResticBackupStatusType extends ResticJsonType {
  final int? secondsElapsed;
  final int? secondsRemaining;
  final double percentDone;
  final int totalFiles;
  final int? filesDone;
  final int totalBytes;
  final int? bytesDone;
  final int? errorCount;
  final List<String>? currentFiles;

  ResticBackupStatusType(
    this.secondsElapsed,
    this.secondsRemaining,
    this.percentDone,
    this.totalFiles,
    this.filesDone,
    this.totalBytes,
    this.bytesDone,
    this.errorCount,
    this.currentFiles,
  );

  double get progress => double.parse((percentDone * 100).toStringAsFixed(1));

  factory ResticBackupStatusType.fromJson(dynamic json) =>
      ResticBackupStatusType(
        json["seconds_elapsed"] ?? 0,
        json["seconds_remaining"],
        double.parse(json["percent_done"].toString()),
        json["total_files"],
        json["files_done"],
        json["total_bytes"],
        json["bytes_done"],
        json["error_count"],
        json["current_files"] != null
            ? List<String>.from(json["current_files"])
            : null,
      );

  @override
  List<Object?> get props => [
        secondsElapsed,
        secondsRemaining,
        percentDone,
        totalFiles,
        filesDone,
        totalBytes,
        bytesDone,
        errorCount,
        currentFiles,
      ];
}

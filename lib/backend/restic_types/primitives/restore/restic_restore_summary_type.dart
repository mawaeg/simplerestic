import '../../base/restic_json_type.dart';

class ResticRestoreSummaryType extends ResticJsonType {
  final int secondsElapsed;
  final int totalFiles;
  final int filesRestored;
  final int? filesSkipped;
  final int? filesDeleted;
  final int? totalBytes;
  final int? bytesRestored;
  final int? bytesSkipped;

  ResticRestoreSummaryType(
    this.secondsElapsed,
    this.totalFiles,
    this.filesRestored,
    this.filesSkipped,
    this.filesDeleted,
    this.totalBytes,
    this.bytesRestored,
    this.bytesSkipped,
  );

  factory ResticRestoreSummaryType.fromJson(dynamic json) =>
      ResticRestoreSummaryType(
        json["seconds_elapsed"] ?? 0,
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
        totalFiles,
        filesRestored,
        filesSkipped,
        filesDeleted,
        totalBytes,
        bytesRestored,
        bytesSkipped,
      ];
}

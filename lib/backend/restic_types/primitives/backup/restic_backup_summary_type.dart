import '../base/restic_base_summary_type.dart';

/// Represents the json output for the backup command of message_type `summary`.
class ResticBackupSummaryType extends ResticBaseSummaryType {
  final double totalDuration;
  final DateTime backupStart;
  final DateTime backupEnd;
  final String snapshotId;

  ResticBackupSummaryType(
    super.filesNew,
    super.filesChanged,
    super.filesUnmodified,
    super.dirsNew,
    super.dirsChanged,
    super.dirsUnmodified,
    super.dataBlobs,
    super.treeBlobs,
    super.dataAdded,
    super.dataAddedPacked,
    super.totalFilesProcessed,
    super.totalBytesProcessed,
    this.totalDuration,
    this.backupStart,
    this.backupEnd,
    this.snapshotId,
  );

  factory ResticBackupSummaryType.fromJson(dynamic json) =>
      ResticBackupSummaryType(
        json["files_new"],
        json["files_changed"],
        json["files_unmodified"],
        json["dirs_new"],
        json["dirs_changed"],
        json["dirs_unmodified"],
        json["data_blobs"],
        json["tree_blobs"],
        json["data_added"],
        json["data_added_packed"],
        json["total_files_processed"],
        json["total_bytes_processed"],
        json["total_duration"],
        DateTime.parse(json["backup_start"]),
        DateTime.parse(json["backup_end"]),
        json["snapshot_id"],
      );

  @override
  List<Object?> get props {
    List<Object?> superProps = super.props;
    superProps.addAll([totalDuration, backupStart, backupEnd, snapshotId]);
    return superProps;
  }
}

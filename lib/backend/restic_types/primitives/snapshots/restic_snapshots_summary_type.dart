import '../base/restic_base_summary_type.dart';

/// Represents the json output for the summary object of the snapshots command of message_type `summary`.
class ResticSnapshotsSummaryType extends ResticBaseSummaryType {
  final DateTime backupStart;
  final DateTime backupEnd;

  ResticSnapshotsSummaryType(
    this.backupStart,
    this.backupEnd,
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
  );

  factory ResticSnapshotsSummaryType.fromJson(dynamic json) =>
      ResticSnapshotsSummaryType(
        DateTime.parse(json["backup_start"]),
        DateTime.parse(json["backup_end"]),
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
      );

  @override
  List<Object?> get props {
    List<Object?> superProps = super.props;
    superProps.addAll([backupStart, backupEnd]);
    return superProps;
  }
}

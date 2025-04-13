import '../../base/restic_json_type.dart';

/// Represents a base class for a json summary object.
///
/// This is currently used in the backup summary and the snapshots summary.
abstract class ResticBaseSummaryType extends ResticJsonType {
  final int filesNew;
  final int filesChanged;
  final int filesUnmodified;
  final int dirsNew;
  final int dirsChanged;
  final int dirsUnmodified;
  final int dataBlobs;
  final int treeBlobs;
  final int dataAdded;
  final int dataAddedPacked;
  final int totalFilesProcessed;
  final int totalBytesProcessed;

  ResticBaseSummaryType(
    this.filesNew,
    this.filesChanged,
    this.filesUnmodified,
    this.dirsNew,
    this.dirsChanged,
    this.dirsUnmodified,
    this.dataBlobs,
    this.treeBlobs,
    this.dataAdded,
    this.dataAddedPacked,
    this.totalFilesProcessed,
    this.totalBytesProcessed,
  );

  @override
  List<Object?> get props => [
        filesNew,
        filesChanged,
        filesUnmodified,
        dirsNew,
        dirsChanged,
        dirsUnmodified,
        dataBlobs,
        treeBlobs,
        dataAdded,
        dataAddedPacked,
        totalFilesProcessed,
        totalBytesProcessed,
      ];
}

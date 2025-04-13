import '../../base/restic_json_type.dart';

//ToDo Add getters in readable format
/// Represents the json output for the snapshots command.
class ResticStatsType extends ResticJsonType {
  final int totalSize;
  final int? totalFileCount;
  final int? totalBlobCount;
  final int snapshotsCount;
  final int? totalUncompressedSize;
  final double? compressionRation;
  final double? compressionProgress;
  final double? compressionSpaceSaving;

  ResticStatsType(
    this.totalSize,
    this.totalFileCount,
    this.totalBlobCount,
    this.snapshotsCount,
    this.totalUncompressedSize,
    this.compressionRation,
    this.compressionProgress,
    this.compressionSpaceSaving,
  );

  factory ResticStatsType.fromJson(Map<String, dynamic> json) =>
      ResticStatsType(
        json["total_size"],
        json["total_file_count"],
        json["total_blob_count"],
        json["snapshots_count"],
        json["total_uncompressed_size"],
        json["compression_ration"],
        json["compression_progress"],
        json["compression_space_saving"],
      );

  @override
  List<Object?> get props => [
        totalSize,
        totalFileCount,
        totalBlobCount,
        snapshotsCount,
        totalUncompressedSize,
        compressionRation,
        compressionProgress,
        compressionSpaceSaving,
      ];
}

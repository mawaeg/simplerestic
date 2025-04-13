import '../../base/restic_json_type.dart';
import 'restic_snapshots_summary_type.dart';

/// Represents the information for a single snapshot given by the snapshots command.
class ResticSnapshotsObjectType extends ResticJsonType {
  final DateTime time;
  final String? parent;
  final String tree;
  final List<String> paths;
  final String hostname;
  final String username;
  final int uid;
  final int gid;
  final String programVersion;
  final ResticSnapshotsSummaryType summary;
  final String id;
  final String shortId;

  ResticSnapshotsObjectType(
    this.time,
    this.parent,
    this.tree,
    this.paths,
    this.hostname,
    this.username,
    this.uid,
    this.gid,
    this.programVersion,
    this.summary,
    this.id,
    this.shortId,
  );

  factory ResticSnapshotsObjectType.fromJson(dynamic json) =>
      ResticSnapshotsObjectType(
        DateTime.parse(json["time"]),
        json["parent"],
        json["tree"],
        List<String>.from(json["paths"]),
        json["hostname"],
        json["username"],
        json["uid"],
        json["gid"],
        json["program_version"],
        ResticSnapshotsSummaryType.fromJson(json["summary"]),
        json["id"],
        json["short_id"],
      );

  @override
  List<Object?> get props => [
        time,
        parent,
        tree,
        paths,
        hostname,
        username,
        uid,
        gid,
        programVersion,
        summary,
        id,
        shortId,
      ];
}

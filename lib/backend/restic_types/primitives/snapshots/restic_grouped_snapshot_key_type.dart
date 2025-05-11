import 'package:equatable/equatable.dart';

class ResticGroupedSnapshotKeyType extends Equatable {
  final String hostname;
  final List<String>? paths;
  final String? tags;

  const ResticGroupedSnapshotKeyType({
    required this.hostname,
    this.paths,
    this.tags,
  });

  factory ResticGroupedSnapshotKeyType.fromJson(Map<String, dynamic> groupKey) {
    return ResticGroupedSnapshotKeyType(
      hostname: groupKey["hostname"],
      paths: List<String>.from(groupKey["paths"]),
      tags: groupKey["tags"],
    );
  }

  @override
  List<Object?> get props => [hostname, paths, tags];
}

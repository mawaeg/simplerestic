class SnapshotModel {
  final int? id;
  final int repositoryId;
  final String path;
  final String alias;

  SnapshotModel({
    this.id,
    required this.repositoryId,
    required this.path,
    required this.alias,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "repositoryId": repositoryId,
      "path": path,
      "alias": alias,
    };
  }

  factory SnapshotModel.fromMap(Map<String, dynamic> map) {
    return SnapshotModel(
      id: map['id'],
      repositoryId: map['repositoryId'],
      path: map['path'],
      alias: map['alias'],
    );
  }
}

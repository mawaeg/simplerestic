class SnapshotModel {
  final int? id;
  final int repositoryId;
  final List<String> pathList;
  String alias;

  static const String _separator = "/;*;\\";

  String get path => getPathListAsFormattedString(pathList);

  static String getPathListAsFormattedString(List<String> path) {
    return path.join(", ");
  }

  static String getPathListAsString(List<String> path) {
    return path.join(_separator);
  }

  static List<String> getPathStringAsList(String path) {
    return path.split(_separator);
  }

  static bool arePathListsIdentical(List<String> path1, List<String> path2) {
    return getPathListAsString(path1) == getPathListAsString(path2);
  }

  SnapshotModel({
    this.id,
    required this.repositoryId,
    required List<String> path,
    required this.alias,
  }) : pathList = path;

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "repositoryId": repositoryId,
      "path": getPathListAsString(pathList),
      "alias": alias,
    };
  }

  factory SnapshotModel.fromMap(Map<String, dynamic> map) {
    return SnapshotModel(
      id: map['id'],
      repositoryId: map['repositoryId'],
      path: getPathStringAsList(map['path']),
      alias: map['alias'],
    );
  }
}

class RepositoryModel {
  final int? id;
  final String path;
  String passwordFile;
  Duration snapshotInterval;
  String? alias;

  RepositoryModel({
    this.id,
    required this.path,
    required this.passwordFile,
    required this.snapshotInterval,
    this.alias,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "path": path,
      "passwordFile": passwordFile,
      "snapshotInterval": snapshotInterval.inSeconds,
      "alias": alias,
    };
  }

  factory RepositoryModel.fromMap(Map<String, dynamic> map) {
    return RepositoryModel(
      id: map["id"],
      path: map["path"],
      passwordFile: map["passwordFile"],
      snapshotInterval: Duration(seconds: map["snapshotInterval"]),
      alias: map["alias"],
    );
  }
}

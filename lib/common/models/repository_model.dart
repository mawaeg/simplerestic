class RepositoryModel {
  final int? id;
  final String path;
  final String passwordFile;
  final String? alias;

  RepositoryModel({
    this.id,
    required this.path,
    required this.passwordFile,
    required this.alias,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "path": path,
      "passwordFile": passwordFile,
      "alias": alias,
    };
  }

  factory RepositoryModel.fromMap(Map<String, dynamic> map) {
    return RepositoryModel(
      id: map["id"],
      path: map["path"],
      passwordFile: map["passwordFile"],
      alias: map["alias"],
    );
  }
}

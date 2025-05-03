import 'base_alias_model.dart';

class RepositoryModel extends BaseAliasModel {
  final String passwordFile;
  //ToDo Make this optional again?
  List<BaseAliasModel> snapshots;

  RepositoryModel({
    required super.path,
    required this.passwordFile,
    required this.snapshots,
    super.alias,
  });

  void addSnapshot(String path, String alias) {
    if (snapshots.any((element) => element.path == path)) {
      removeSnapshot(path);
    }
    snapshots.add(BaseAliasModel(path: path, alias: alias));
  }

  void removeSnapshot(String path) {
    snapshots.removeAt(snapshots.indexWhere((element) => element.path == path));
  }

  String? getSnapshotByPath(String path) {
    return snapshots
        .where((element) => element.path == path)
        .firstOrNull
        ?.alias;
  }

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    List<BaseAliasModel> snapshots = [];
    if (json["snapshots"] != null) {
      for (var snapshot in json["snapshots"]) {
        snapshots.add(BaseAliasModel.fromJson(snapshot));
      }
    }
    RepositoryModel model = RepositoryModel(
      path: json["path"],
      passwordFile: json["passwordFile"],
      alias: json["alias"],
      snapshots: snapshots.isNotEmpty ? snapshots : [],
    );
    return model;
  }

  @override
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> entries = [];
    for (BaseAliasModel snapshot in snapshots) {
      entries.add(snapshot.toJson());
    }
    Map<String, dynamic> json = super.toJson();
    json["snapshots"] = entries.isNotEmpty ? entries : null;
    json["passwordFile"] = passwordFile;
    return json;
  }

  @override
  List<Object?> get props => [path, alias, passwordFile, snapshots];
}

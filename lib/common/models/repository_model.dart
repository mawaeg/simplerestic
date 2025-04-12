import 'package:simplerestic/common/models/base_alias_model.dart';

class RepositoryModel extends BaseAliasModel {
  final String passwordFile;
  final List<BaseAliasModel>? snapshots;

  const RepositoryModel({
    required super.path,
    required this.passwordFile,
    super.alias,
    this.snapshots,
  });

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
      snapshots: snapshots.isNotEmpty ? snapshots : null,
    );
    return model;
  }

  @override
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> entries = [];
    for (BaseAliasModel snapshot in snapshots ?? []) {
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

class CreateRepositoryModel {
  String? path;
  String? passwordFile;
  String? alias;

  bool isAliasExisting() {
    return alias != null && alias!.isNotEmpty;
  }
}

class CreateRepositoryModel {
  String? path;
  String? passwordFile;
  String? alias;
  bool isSuccessful = false;

  void clear() {
    path = null;
    passwordFile = null;
    alias = null;
    isSuccessful = false;
  }

  bool isAliasExisting() {
    return alias != null && alias!.isNotEmpty;
  }
}

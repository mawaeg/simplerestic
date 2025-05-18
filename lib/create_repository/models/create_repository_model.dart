class CreateRepositoryModel {
  String? path;
  String? passwordFile;
  String? alias;
  Duration? snapshotInterval;
  bool isSuccessful = false;

  void clear() {
    path = null;
    passwordFile = null;
    alias = null;
    snapshotInterval = null;
    isSuccessful = false;
  }

  bool isAliasExisting() {
    return alias != null && alias!.isNotEmpty;
  }
}

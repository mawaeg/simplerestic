import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/common/models/repository_list_model.dart';
import 'package:simplerestic/common/models/repository_model.dart';

void main() {
  group("Test the RepositoryListModel.", () {
    test(
        "RepositoryListModel should be able to create a empty list of RepositoryModel from a json and return the list with getRepositories().",
        () {
      final Map<String, dynamic> json = {"repositories": []};
      final RepositoryListModel model = RepositoryListModel.fromJson(json);

      expect(model.getRepositories(), isEmpty);

      expect(model.toJson(), json);
    });

    test(
        "RepositoryListModel should be able to create a list of RepositoryModel from a json and return the list with getRepositories().",
        () {
      final Map<String, dynamic> json = {
        "repositories": [
          {"path": "testPath", "passwordFile": "testPasswordFile"},
          {"path": "testPath2", "passwordFile": "testPasswordFile2"},
        ]
      };
      final RepositoryListModel model = RepositoryListModel.fromJson(json);

      expect(model.getRepositories().length, json["repositories"].length);

      // Only check for length, as RepositoryModel is used and this is tested separately.
      expect(
          model.toJson()["repositories"].length, json["repositories"].length);
    });
    test(
        "RepositoryListModel should be able to add and remove repositories with addRepository() and removeRepository().",
        () {
      final RepositoryModel testRepository = RepositoryModel(
        path: "testPath",
        passwordFile: "testPasswordFile",
      );

      final RepositoryListModel model = RepositoryListModel();
      expect(model.getRepositories(), isEmpty);
      model.addRepository(testRepository);
      expect(model.getRepositories().length, 1);
      model.removeRepository(testRepository);
      expect(model.getRepositories(), isEmpty);
    });
  });
}

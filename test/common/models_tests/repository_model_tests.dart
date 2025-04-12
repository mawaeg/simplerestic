import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/common/models/base_alias_model.dart';
import 'package:simplerestic/common/models/repository_model.dart';

void main() {
  group("Test the RepositoryModel", () {
    test(
        "RepositoryModel should be able to serialize / deserialize json data including one snapshot.",
        () {
      final String testPath = "testPath";
      final String testPasswordFile = "testPasswordFile";
      final String testAlias = "testAlias";
      final List<Map<String, dynamic>> snapshots = [
        BaseAliasModel(path: "testPath").toJson()
      ];
      Map<String, dynamic> json = {
        "path": testPath,
        "passwordFile": testPasswordFile,
        "alias": testAlias,
        "snapshots": snapshots,
      };

      final RepositoryModel model = RepositoryModel.fromJson(json);

      expect(model.path, testPath);
      expect(model.passwordFile, testPasswordFile);
      expect(model.alias, testAlias);

      expect(model.snapshots, isNotNull);
      expect(model.snapshots!.length, snapshots.length);

      Map<String, dynamic> toJsonResult = model.toJson();
      expect(toJsonResult, json);
    });
    test(
        "RepositoryModel should be able to serialize / deserialize json data including more than one snapshot.",
        () {
      final String testPath = "testPath";
      final String testPasswordFile = "testPasswordFile";
      final String testAlias = "testAlias";
      final List<Map<String, dynamic>> snapshots = [
        BaseAliasModel(path: "testPath").toJson(),
        BaseAliasModel(path: "testPath2").toJson(),
      ];
      Map<String, dynamic> json = {
        "path": testPath,
        "passwordFile": testPasswordFile,
        "alias": testAlias,
        "snapshots": snapshots,
      };

      final RepositoryModel model = RepositoryModel.fromJson(json);

      expect(model.path, testPath);
      expect(model.passwordFile, testPasswordFile);
      expect(model.alias, testAlias);

      expect(model.snapshots, isNotNull);
      expect(model.snapshots!.length, snapshots.length);

      Map<String, dynamic> toJsonResult = model.toJson();
      expect(toJsonResult, json);
    });
    test(
        "RepositoryModel should be able to serialize / deserialize json data with including no snapshots.",
        () {
      final String testPath = "testPath";
      final String testPasswordFile = "testPasswordFile";
      final String testAlias = "testAlias";
      Map<String, dynamic> json = {
        "path": testPath,
        "passwordFile": testPasswordFile,
        "alias": testAlias,
        "snapshots": null,
      };

      final RepositoryModel model = RepositoryModel.fromJson(json);

      expect(model.path, testPath);
      expect(model.passwordFile, testPasswordFile);
      expect(model.alias, testAlias);
      expect(model.snapshots, isNull);

      Map<String, dynamic> toJsonResult = model.toJson();
      expect(toJsonResult, json);
    });
  });
}

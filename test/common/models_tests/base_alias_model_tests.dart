import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/common/models/base_alias_model.dart';

void main() {
  group("Test the BaseAliasModel.", () {
    test(
        "BaseAliasModel should be able to serialize / deserialize json data with all possible parameters.",
        () {
      final String testPath = "testPath";
      final String testAlias = "testAlias";
      Map<String, dynamic> json = {"path": testPath, "alias": testAlias};

      final BaseAliasModel model = BaseAliasModel.fromJson(json);

      expect(model.path, testPath);
      expect(model.alias, testAlias);

      Map<String, dynamic> toJsonResult = model.toJson();
      expect(toJsonResult, json);
    });
    test(
        "BaseAliasModel should be able to serialize / deserialize json data with only mandatory parameters.",
        () {
      final String testPath = "testPath";
      Map<String, dynamic> json = {"path": testPath, "alias": null};

      final BaseAliasModel model = BaseAliasModel.fromJson(json);

      expect(model.path, testPath);
      expect(model.alias, null);

      Map<String, dynamic> toJsonResult = model.toJson();
      expect(toJsonResult, json);
    });
  });
}

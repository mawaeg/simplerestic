import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/create_repository/models/create_repository_model.dart';

void main() {
  group("Test the CreateRepositoryModel", () {
    test(
        "CreateRepositoryModel should be able to validate if a alias is existing.",
        () {
      CreateRepositoryModel model = CreateRepositoryModel();
      expect(model.isAliasExisting(), false);
      model.alias = "";
      expect(model.isAliasExisting(), false);
      model.alias = "testAlias";
      expect(model.isAliasExisting(), true);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/utils/normalize_enum_name.dart';

void main() {
  test("Ensure normalizeCommandEnum correctly formats a string.", () {
    // Check if string is correctly formatted
    expect(normalizeCommandEnum("test_enum_name"), "--test-enum-name");
    // Check that String is not formatted if no "_" is contained in the String.
    expect(normalizeCommandEnum("test"), "--test");
  });
}

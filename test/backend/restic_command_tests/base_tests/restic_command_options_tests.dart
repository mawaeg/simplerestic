import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_option_type.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_options.dart';

void main() {
  test("Ensure ResticCommandOption correctly outputs the command option.", () {
    expect(
      ResticCommandOption(ResticCommandOptionType.repo, "test").build(),
      ["--repo", "test"],
    );
  });
}

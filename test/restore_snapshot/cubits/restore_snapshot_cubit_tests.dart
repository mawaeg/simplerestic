import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command_option_type.dart';
import 'package:simplerestic/restore_snapshot/cubits/restore_snapshot_cubit.dart';

void main() {
  group(RestoreSnapshotCubit, () {
    late RestoreSnapshotCubit restoreSnapshotCubit;

    setUp(() {
      restoreSnapshotCubit = RestoreSnapshotCubit();
    });

    void expectDefaultValues() {
      expect(restoreSnapshotCubit.state.target, null);
      expect(restoreSnapshotCubit.state.overwriteStrategy,
          ResticOverwriteOptionTypeValues.always);
      expect(restoreSnapshotCubit.state.delete, false);
      expect(restoreSnapshotCubit.state.inplaceRestore, false);
      expect(restoreSnapshotCubit.state.warningsAccepted, false);
    }

    test("initial state is []", () {
      expectDefaultValues();
    });

    test("Assert that setTarget correctly sets the target", () {
      restoreSnapshotCubit.setTarget("/test/Path");
      expect(restoreSnapshotCubit.state.target, equals("/test/Path"));
    });

    test(
        "Assert that setOverwriteStrategy correctly sets the overwrite strategy",
        () {
      restoreSnapshotCubit
          .setOverwriteStrategy(ResticOverwriteOptionTypeValues.if_changed);
      expect(
        restoreSnapshotCubit.state.overwriteStrategy,
        equals(ResticOverwriteOptionTypeValues.if_changed),
      );
    });

    test("Assert that setDelete correctly sets the delete option", () {
      restoreSnapshotCubit.setDelete(true);
      expect(restoreSnapshotCubit.state.delete, equals(true));
    });

    test(
        "Assert that setInplaceRestore correctly sets the inplace restore option",
        () {
      restoreSnapshotCubit.setInplaceRestore(true);
      expect(restoreSnapshotCubit.state.inplaceRestore, equals(true));
    });

    test("Assert that setWarningsAccepted correctly sets the warnings accepted",
        () {
      restoreSnapshotCubit.setWarningsAccepted(true);
      expect(restoreSnapshotCubit.state.warningsAccepted, equals(true));
    });

    test("Assert that clearData resets the state", () {
      // Load cubit with data to make sure data is cleared
      restoreSnapshotCubit.setTarget("/test/Path");
      restoreSnapshotCubit
          .setOverwriteStrategy(ResticOverwriteOptionTypeValues.if_changed);
      restoreSnapshotCubit.setDelete(true);
      restoreSnapshotCubit.setInplaceRestore(true);
      restoreSnapshotCubit.setWarningsAccepted(true);

      restoreSnapshotCubit.clearData();
      expectDefaultValues();
    });
  });
}

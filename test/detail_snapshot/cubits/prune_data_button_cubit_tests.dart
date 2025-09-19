import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/detail_snapshot/cubits/prune_data_button_cubit.dart';

void main() {
  group(PruneDataButtonCubit, () {
    late PruneDataButtonCubit pruneDataButtonCubit;

    setUp(() {
      pruneDataButtonCubit = PruneDataButtonCubit();
    });

    test("initial state is `false`", () {
      expect(pruneDataButtonCubit.state, equals(true));
    });

    test("Assert that toggle correctly toggles the state", () {
      pruneDataButtonCubit.set(true);
      expect(pruneDataButtonCubit.state, isTrue);
      pruneDataButtonCubit.set(false);
      expect(pruneDataButtonCubit.state, isFalse);
    });
  });
}

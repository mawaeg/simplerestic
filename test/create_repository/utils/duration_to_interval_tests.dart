import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/common/models/snapshot_interval_options_enum.dart';
import 'package:simplerestic/create_repository/utils/duration_to_interval.dart';
import 'package:tuple/tuple.dart';

void main() {
  group("Assert that durationToInterval works as expected and", () {
    test("converts a duration thats a multiple of 365 days to a years interval",
        () {
      final duration = Duration(days: 365 * 2);
      final interval = durationToInterval(duration);
      expect(interval, Tuple2("2", SnapshotIntervalOptionsEnum.years));
    });

    test("converts a duration thats a multiple of 31 days to a months interval",
        () {
      final duration = Duration(days: 31 * 3);
      final interval = durationToInterval(duration);
      expect(interval, Tuple2("3", SnapshotIntervalOptionsEnum.months));
    });

    test("converts a duration thats a multiple of 7 days to a weeks interval",
        () {
      final duration = Duration(days: 7);
      final interval = durationToInterval(duration);
      expect(interval, Tuple2("1", SnapshotIntervalOptionsEnum.weeks));
    });

    test("converts a duration thats a multiple of 24 hours to a days interval",
        () {
      final duration = Duration(hours: 24 * 4);
      final interval = durationToInterval(duration);
      expect(interval, Tuple2("4", SnapshotIntervalOptionsEnum.days));
    });

    test("converts any other duration to an hour interval", () {
      final duration = Duration(hours: 13);
      final interval = durationToInterval(duration);
      expect(interval, Tuple2("13", SnapshotIntervalOptionsEnum.hours));
    });

    test("converts a sub hour duration to an hour interval", () {
      final duration = Duration(minutes: 30);
      final interval = durationToInterval(duration);
      expect(interval, Tuple2("0", SnapshotIntervalOptionsEnum.hours));
    });
  });
}

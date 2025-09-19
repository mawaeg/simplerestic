import 'package:tuple/tuple.dart';

import '../../common/models/snapshot_interval_options_enum.dart';

Tuple2<String, SnapshotIntervalOptionsEnum> durationToInterval(
    Duration duration) {
  if (duration.inDays % 365 == 0 && duration.inDays > 0) {
    return Tuple2(
      (duration.inDays / 365).toStringAsFixed(0),
      SnapshotIntervalOptionsEnum.years,
    );
  }
  if (duration.inDays % 31 == 0 && duration.inDays > 0) {
    return Tuple2(
      (duration.inDays / 31).toStringAsFixed(0),
      SnapshotIntervalOptionsEnum.months,
    );
  }
  if (duration.inDays % 7 == 0 && duration.inDays > 0) {
    return Tuple2(
      (duration.inDays / 7).toStringAsFixed(0),
      SnapshotIntervalOptionsEnum.weeks,
    );
  }
  if (duration.inHours % 24 == 0 && duration.inHours > 0) {
    return Tuple2(
      (duration.inHours / 24).toStringAsFixed(0),
      SnapshotIntervalOptionsEnum.days,
    );
  }
  return Tuple2(
    duration.inHours.toStringAsFixed(0),
    SnapshotIntervalOptionsEnum.hours,
  );
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/snapshot_model.dart';
import '../utils/date_time_to_string.dart';

class SnapshotListTileSubtitleWidget extends StatelessWidget {
  final String formattedPath;
  final List<ResticSnapshotsObjectType> snapshots;
  final SnapshotModel? snapshot;

  const SnapshotListTileSubtitleWidget(
      {super.key,
      required this.formattedPath,
      required this.snapshots,
      this.snapshot});

  @override
  Widget build(BuildContext context) {
    DateTime lastBackup = snapshots.last.time.toLocal();
    int minimumTime =
        DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch;
    bool isBackupNeeded = minimumTime > lastBackup.millisecondsSinceEpoch;
    return Row(
      children: [
        Icon(
          YaruIcons.media_record,
          size: 15,
          color:
              isBackupNeeded ? YaruColors.adwaitaRed : YaruColors.adwaitaGreen,
        ),
        Text("Last backup: ${dateTime2String(snapshots.last.time.toLocal())}"),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';
import '../../common/models/snapshot_model.dart';
import '../utils/date_time_to_string.dart';
import '../utils/is_backup_needed.dart';

class SnapshotListTileSubtitleWidget extends StatelessWidget {
  final String formattedPath;
  final List<ResticSnapshotsObjectType> snapshots;
  final RepositoryModel repository;
  final SnapshotModel? snapshot;

  const SnapshotListTileSubtitleWidget({
    super.key,
    required this.formattedPath,
    required this.snapshots,
    required this.repository,
    this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    bool backupNeeded = isBackupNeeded(repository, snapshots.last);
    return Row(
      children: [
        Icon(
          YaruIcons.media_record,
          size: 15,
          color: backupNeeded ? YaruColors.adwaitaRed : YaruColors.adwaitaGreen,
        ),
        Text("Last backup: ${dateTime2String(snapshots.last.time.toLocal())}"),
      ],
    );
  }
}

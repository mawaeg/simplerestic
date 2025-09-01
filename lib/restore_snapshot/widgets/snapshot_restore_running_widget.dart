import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/restore/restic_restore_status_type.dart';

class SnapshotRestoreRunningWidget extends StatelessWidget {
  final ResticRestoreStatusType summary;

  const SnapshotRestoreRunningWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        YaruLinearProgressIndicator(value: summary.percentDone),
        Text("Seconds elapsed: ${summary.secondsElapsed}s"),
        Text(
          "${(summary.filesRestored ?? 0) + (summary.filesDeleted ?? 0) + (summary.filesSkipped ?? 0)}/${summary.totalFiles} files done.",
        ),
      ],
    );
  }
}

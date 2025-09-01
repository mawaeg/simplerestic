import 'package:flutter/material.dart';

import '../../backend/restic_types/primitives/restore/restic_restore_summary_type.dart';
import '../../backend/restic_types/restic_return_type.dart';

class SnapshotRestoreSummaryWidget extends StatelessWidget {
  final ResticRestoreSummaryType summary;
  final ResticReturnType returnType;

  const SnapshotRestoreSummaryWidget({
    super.key,
    required this.summary,
    required this.returnType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Restoring finished with exit code ${returnType.exitCode} in ${summary.secondsElapsed.toStringAsFixed(2)} seconds.",
        ),
        Text("Restored files: ${summary.filesRestored}"),
        Text("Skipped files: ${summary.filesSkipped ?? 0}"),
        Text("Deleted files: ${summary.filesDeleted ?? 0}"),
      ],
    );
  }
}

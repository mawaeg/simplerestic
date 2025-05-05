import 'package:flutter/material.dart';

import '../../backend/restic_types/primitives/backup/restic_backup_summary_type.dart';
import '../../backend/restic_types/restic_return_type.dart';

class BackupSummaryWidget extends StatelessWidget {
  final ResticBackupSummaryType summary;
  final ResticReturnType returnType;

  const BackupSummaryWidget({
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
            "Backup finished with exit code ${returnType.exitCode} in ${summary.totalDuration.toStringAsFixed(2)} seconds."),
        Text("New files: ${summary.filesNew}"),
        Text("Changed files: ${summary.filesChanged}"),
        Text("Unmodified files: ${summary.filesUnmodified}"),
      ],
    );
  }
}

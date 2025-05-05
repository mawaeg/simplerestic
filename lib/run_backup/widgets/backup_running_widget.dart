import 'package:flutter/material.dart';
import 'package:yaru/widgets.dart';

import '../../backend/restic_types/primitives/backup/restic_backup_status_type.dart';

class BackupRunningWidget extends StatelessWidget {
  final ResticBackupStatusType status;

  const BackupRunningWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.0,
      children: [
        YaruLinearProgressIndicator(value: status.percentDone),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Seconds elapsed: ${status.secondsElapsed}s"),
              Text("Seconds remaining: ${status.secondsRemaining ?? '?'}s"),
              Text("${status.filesDone}/${status.totalFiles} files done.")
            ],
          ),
        ),
      ],
    );
  }
}

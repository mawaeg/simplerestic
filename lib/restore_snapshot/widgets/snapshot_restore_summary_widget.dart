import 'package:flutter/material.dart';

import '../../backend/restic_command/restic_command_restore.dart';
import '../../backend/restic_types/primitives/restore/restic_restore_summary_type.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../backend/restic_types/restic_return_type.dart';
import '../../common/widgets/open_folder_button_widget.dart';

class SnapshotRestoreSummaryWidget extends StatelessWidget {
  final ResticRestoreSummaryType summary;
  final ResticReturnType returnType;
  final ResticCommandRestore command;
  final ResticSnapshotsObjectType snapshotObject;

  const SnapshotRestoreSummaryWidget({
    super.key,
    required this.summary,
    required this.returnType,
    required this.command,
    required this.snapshotObject,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OpenFolderButtonWidget(path: command.target),
          ],
        ),
      ],
    );
  }
}

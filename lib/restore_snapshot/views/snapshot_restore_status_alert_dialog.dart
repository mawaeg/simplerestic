import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_restore.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/primitives/restore/restic_restore_status_type.dart';
import '../../backend/restic_types/primitives/restore/restic_restore_summary_type.dart';
import '../../backend/restic_types/restic_return_type.dart';
import '../../common/utils/shortened_id.dart';
import '../widgets/snapshot_restore_running_widget.dart';
import '../widgets/snapshot_restore_summary_widget.dart';

class SnapshotRestoreStatusAlertDialog extends StatelessWidget {
  final String id;
  final ResticCommandRestore command;

  const SnapshotRestoreStatusAlertDialog({
    super.key,
    required this.id,
    required this.command,
  });

  @override
  Widget build(BuildContext context) {
    ResticRestoreSummaryType? summary;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Restore ${getShortenedId(id)}"),
        isClosable: true,
      ),
      content: SizedBox(
        width: 350,
        height: 100,
        child: StreamBuilder(
          stream: ResticCommandExecutor(command).executeCommand(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center();
            } else if (snapshot.data is ResticRestoreSummaryType) {
              summary = snapshot.data as ResticRestoreSummaryType;
            } else if (snapshot.data is ResticRestoreStatusType) {
              return SnapshotRestoreRunningWidget(
                  summary: snapshot.data as ResticRestoreStatusType);
            } else if (snapshot.data is ResticReturnType && summary != null) {
              return SnapshotRestoreSummaryWidget(
                  summary: summary!,
                  returnType: snapshot.data as ResticReturnType);
            } else if (snapshot.data is ResticReturnType) {
              return Text(
                  "Restoring finished with exit code ${(snapshot.data as ResticReturnType).exitCode}");
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Text("Unknown error.");
            }
            return Center();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_backup.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/primitives/base/restic_base_error_type.dart';
import '../../backend/restic_types/primitives/backup/restic_backup_summary_type.dart';
import '../../backend/restic_types/restic_error_type.dart';
import '../../common/cubits/snapshot_rebuild_cubit.dart';
import '../widgets/run_backup_stream_builder_widget.dart';

class RunBackupAlertDialog extends StatelessWidget {
  final ResticCommandBackup backupCommand;
  final bool dryRun;

  const RunBackupAlertDialog({
    super.key,
    required this.backupCommand,
    this.dryRun = false,
  });

  @override
  Widget build(BuildContext context) {
    ResticBackupSummaryType? summary;
    ResticErrorType? errorType;
    ResticBaseErrorType? backupErrorType;
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Performing backup ${dryRun ? '(Dry run)' : ''}"),
        // ToDo Add mechanism to properly abort backup
        isClosable: true,
        onClose: (_) async {
          context.read<SnapshotRebuildCubit>().toggle();
          await Navigator.maybePop(context);
        },
      ),
      content: SizedBox(
        height: 100,
        child: StreamBuilder(
            stream: ResticCommandExecutor().executeCommand(backupCommand),
            builder: (context, snapshot) {
              // If no data is provided show blank widget
              if (!snapshot.hasData) return Center();

              // Save summary and error
              if (snapshot.data is ResticBackupSummaryType) {
                summary = snapshot.data as ResticBackupSummaryType;
              }
              if (snapshot.data is ResticBaseErrorType) {
                backupErrorType = snapshot.data as ResticBaseErrorType;
              }
              if (snapshot.data is ResticErrorType) {
                errorType = snapshot.data as ResticErrorType;
              }

              return RunBackupStreamBuilderWidget(
                data: snapshot.data!,
                connectionState: snapshot.connectionState,
                summary: summary,
                backupErrorType: backupErrorType,
                errorType: errorType,
              );
            }),
      ),
    );
  }
}

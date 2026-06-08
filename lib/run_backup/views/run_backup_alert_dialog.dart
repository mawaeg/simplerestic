import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_backup.dart';
import '../../backend/restic_types/base/restic_scripting_base_type.dart';
import '../../backend/restic_types/primitives/backup/restic_backup_status_type.dart';
import '../../common/cubits/snapshot_rebuild_cubit.dart';
import '../blocs/backup_queue_bloc.dart';
import '../models/backup_queue_event.dart';
import '../models/backup_queue_state.dart';
import '../models/finished_backup_model.dart';
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
    FinishedBackupModel? finishedBackup;
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
        child: BlocBuilder<BackupQueueBloc, BackupQueueState>(
            builder: (context, state) {
          ResticScriptingBaseType? data = state.lastOutput;
          if (state.isCommandQueued(backupCommand)) {
            return Center(
              child: Text("Command is currently queued to be executed."),
            );
          }
          // Check if we have previous data:
          int finishedBackupsIndex = state.finishedBackups
              .indexWhere((element) => element.command == backupCommand);
          if (finishedBackupsIndex != -1) {
            context
                .read<BackupQueueBloc>()
                .add(RemoveFinishedCommand(backupCommand));
            finishedBackup = state.finishedBackups[finishedBackupsIndex];
          }
          ResticBackupStatusType? statusType;
          if (data is ResticBackupStatusType &&
              state.currentCommand == backupCommand) {
            statusType = data;
          }
          return RunBackupStreamBuilderWidget(
            isActive: state.isActive && state.currentCommand == backupCommand,
            statusType: statusType,
            finishedBackupModel: finishedBackup,
          );
        }),
      ),
    );
  }
}

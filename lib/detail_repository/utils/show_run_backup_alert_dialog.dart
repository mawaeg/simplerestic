import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/restic_command/restic_command_backup.dart';
import '../../common/models/repository_model.dart';
import '../../run_backup/blocs/backup_queue_bloc.dart';
import '../../run_backup/models/backup_queue_event.dart';
import '../../run_backup/views/run_backup_alert_dialog.dart';
import 'build_backup_command.dart';

Future<void> showRunBackupAlertDialog(
  BuildContext context,
  RepositoryModel repository,
  List<String> path, {
  bool dryRun = false,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      ResticCommandBackup command = buildBackupCommand(
        repository,
        path,
        dryRun: dryRun,
      );

      // If Backup is not yet added to queue / running or finished: Add Backup to queue and show RunBackupAlertDialog
      if (!context.read<BackupQueueBloc>().state.isCommandAdded(command) &&
          !context.read<BackupQueueBloc>().state.isCommandFinished(command)) {
        context.read<BackupQueueBloc>().add(AddCommand(command));
      }
      return RunBackupAlertDialog(
        backupCommand: command,
        dryRun: dryRun,
      );
    },
  );
}

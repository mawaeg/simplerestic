import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/repository_model.dart';
import '../../run_backup/blocs/backup_queue_bloc.dart';
import '../../run_backup/models/backup_queue_state.dart';
import '../utils/build_backup_command.dart';
import 'buttons/backup_finished_button.dart';
import 'buttons/backup_queued_button.dart';
import 'buttons/backup_running_button.dart';
import 'buttons/run_backup_button.dart';

class RunBackupButtonSelectorWidget extends StatelessWidget {
  final RepositoryModel repository;
  final List<String> path;

  const RunBackupButtonSelectorWidget({
    super.key,
    required this.repository,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackupQueueBloc, BackupQueueState>(
      builder: (context, state) {
        if (state.currentCommand == buildBackupCommand(repository, path)) {
          return BackupRunningButton(repository, path);
        }
        if (state.isCommandQueued(buildBackupCommand(repository, path))) {
          return BackupQueuedButton(repository, path);
        }
        if (state.isCommandFinished(buildBackupCommand(repository, path))) {
          return BackupFinishedButton(repository, path);
        }
        return RunBackupButton(repository, path);
      },
    );
  }
}

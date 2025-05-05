import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_backup.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/primitives/backup/restic_backup_error_type.dart';
import '../../backend/restic_types/primitives/backup/restic_backup_summary_type.dart';
import '../../backend/restic_types/restic_error_type.dart';
import '../../common/models/repository_model.dart';
import '../widgets/run_backup_stream_builder_widget.dart';

class RunBackupAlertDialog extends StatelessWidget {
  final RepositoryModel repository;
  final String path;

  const RunBackupAlertDialog({
    super.key,
    required this.repository,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    ResticBackupSummaryType? summary;
    ResticErrorType? errorType;
    ResticBackupErrorType? backupErrorType;
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Performing backup"),
        // ToDo Add mechanism to properly abort backup
        isClosable: true,
      ),
      content: SizedBox(
        height: 100,
        child: StreamBuilder(
            stream: ResticCommandExecutor(ResticCommandBackup(
                    repository: repository.path,
                    passwordFile: repository.passwordFile,
                    path: path))
                .executeCommand(),
            builder: (context, snapshot) {
              // If no data is provided show blank widget
              if (!snapshot.hasData) return Center();

              // Save summary and error
              if (snapshot.data is ResticBackupSummaryType) {
                summary = snapshot.data as ResticBackupSummaryType;
              }
              if (snapshot.data is ResticBackupErrorType) {
                backupErrorType = snapshot.data as ResticBackupErrorType;
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

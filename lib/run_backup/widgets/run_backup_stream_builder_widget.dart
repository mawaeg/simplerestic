import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/backup/restic_backup_status_type.dart';
import '../models/finished_backup_model.dart';
import '../widgets/backup_failed_widget.dart';
import '../widgets/backup_running_widget.dart';
import '../widgets/backup_summary_widget.dart';

class RunBackupStreamBuilderWidget extends StatelessWidget {
  final bool isActive;
  final ResticBackupStatusType? statusType;
  final FinishedBackupModel? finishedBackupModel;

  const RunBackupStreamBuilderWidget({
    super.key,
    this.isActive = false,
    this.statusType,
    this.finishedBackupModel,
  });

  @override
  Widget build(BuildContext context) {
    // Unknown error in case command is not active anymore, but no returnType received
    if (finishedBackupModel?.returnType == null && !isActive) {
      // TBD Search in finished backups and if existing set as summary, error and returnType and otherwise show error.
      return Text("Unknown error");
    }
    if (statusType != null) {
      return BackupRunningWidget(status: statusType!);
    }
    if (finishedBackupModel?.returnType != null) {
      if (finishedBackupModel?.summaryType != null) {
        return BackupSummaryWidget(
          summary: finishedBackupModel!.summaryType!,
          returnType: finishedBackupModel!.returnType!,
        );
      }
      if (finishedBackupModel?.errorType != null) {
        return BackupFailedWidget(
          error: finishedBackupModel!.errorType!.error,
          returnType: finishedBackupModel!.returnType!,
        );
      }
      if (finishedBackupModel?.backupErrorType != null) {
        return BackupFailedWidget(
          error: finishedBackupModel!.backupErrorType!.errorMessage,
          returnType: finishedBackupModel!.returnType!,
        );
      }
      return Text(
          "Backup finished with exit code ${finishedBackupModel?.returnType!.exitCode}.");
    }
    return Center(child: YaruCircularProgressIndicator());
  }
}

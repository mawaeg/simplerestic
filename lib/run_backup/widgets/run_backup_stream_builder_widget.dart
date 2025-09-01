import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/base/restic_scripting_base_type.dart';
import '../../backend/restic_types/primitives/base/restic_base_error_type.dart';
import '../../backend/restic_types/primitives/backup/restic_backup_status_type.dart';
import '../../backend/restic_types/primitives/backup/restic_backup_summary_type.dart';
import '../../backend/restic_types/restic_error_type.dart';
import '../../backend/restic_types/restic_return_type.dart';
import '../widgets/backup_failed_widget.dart';
import '../widgets/backup_running_widget.dart';
import '../widgets/backup_summary_widget.dart';

class RunBackupStreamBuilderWidget extends StatelessWidget {
  final ResticScriptingBaseType data;
  final ConnectionState connectionState;

  final ResticBackupSummaryType? summary;
  final ResticErrorType? errorType;
  final ResticBaseErrorType? backupErrorType;

  const RunBackupStreamBuilderWidget({
    super.key,
    required this.data,
    required this.connectionState,
    this.summary,
    this.errorType,
    this.backupErrorType,
  });

  @override
  Widget build(BuildContext context) {
    if (data is ResticBackupStatusType) {
      return BackupRunningWidget(status: data as ResticBackupStatusType);
    } else if (data is ResticReturnType && summary != null) {
      return BackupSummaryWidget(
        summary: summary!,
        returnType: data as ResticReturnType,
      );
    } else if (data is ResticReturnType && errorType != null) {
      return BackupFailedWidget(
        error: errorType!.error,
        returnType: data as ResticReturnType,
      );
    } else if (data is ResticReturnType && backupErrorType != null) {
      return BackupFailedWidget(
        error: backupErrorType!.errorMessage,
        returnType: data as ResticReturnType,
      );
    } else if (data is ResticReturnType) {
      return Text(
          "Backup finished with exit code ${(data as ResticReturnType).exitCode}.");
    } else if (connectionState == ConnectionState.done) {
      return Text("Unknown error.");
    }
    return Center(child: YaruCircularProgressIndicator());
  }
}

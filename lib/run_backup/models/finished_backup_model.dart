import 'package:equatable/equatable.dart';

import '../../backend/restic_command/base/restic_command.dart';
import '../../backend/restic_types/primitives/backup/restic_backup_summary_type.dart';
import '../../backend/restic_types/primitives/base/restic_base_error_type.dart';
import '../../backend/restic_types/restic_error_type.dart';
import '../../backend/restic_types/restic_return_type.dart';

class FinishedBackupModel extends Equatable {
  final ResticCommand command;
  final ResticBackupSummaryType? summaryType;
  final ResticReturnType? returnType;
  final ResticErrorType? errorType;
  final ResticBaseErrorType? backupErrorType;

  const FinishedBackupModel({
    required this.command,
    this.summaryType,
    this.returnType,
    this.errorType,
    this.backupErrorType,
  });

  FinishedBackupModel copyWith({
    ResticCommand? command,
    ResticBackupSummaryType? summaryType,
    ResticReturnType? returnType,
    ResticErrorType? errorType,
    ResticBaseErrorType? backupErrorType,
  }) {
    return FinishedBackupModel(
        command: command ?? this.command,
        summaryType: summaryType ?? this.summaryType,
        returnType: returnType ?? this.returnType,
        errorType: errorType ?? this.errorType,
        backupErrorType: backupErrorType ?? this.backupErrorType);
  }

  @override
  List<Object?> get props =>
      [command, summaryType, returnType, errorType, backupErrorType];
}

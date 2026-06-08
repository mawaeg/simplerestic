import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/restic_command/base/restic_command.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/base/restic_scripting_base_type.dart';
import '../../backend/restic_types/primitives/backup/restic_backup_summary_type.dart';
import '../../backend/restic_types/primitives/base/restic_base_error_type.dart';
import '../../backend/restic_types/restic_error_type.dart';
import '../../backend/restic_types/restic_return_type.dart';
import '../models/backup_queue_event.dart';
import '../models/backup_queue_state.dart';
import '../models/finished_backup_model.dart';

class BackupQueueBloc extends Bloc<BackupQueueEvent, BackupQueueState> {
  final ResticCommandExecutor executor;
  BackupQueueBloc({this.executor = const ResticCommandExecutor()})
      : super(BackupQueueState.initial()) {
    on<AddCommand>(_onAddCommand);
    on<ProcessNext>(_onProcessNext);
    on<RemoveFinishedCommand>(_onRemoveFinishedCommand);
  }

  void _onAddCommand(AddCommand event, Emitter<BackupQueueState> emit) {
    Queue<ResticCommand> queue = Queue<ResticCommand>.from(state.queue)
      ..add(event.command);
    emit(state.copyWith(queue: queue));

    if (!state.isActive) {
      add(ProcessNext());
    }
  }

  void _onProcessNext(ProcessNext event, Emitter<BackupQueueState> emit) async {
    if (state.queue.isEmpty) {
      return;
    }

    final ResticCommand currentCommand = state.queue.first;
    final Queue<ResticCommand> updatedQueue =
        Queue<ResticCommand>.from(state.queue)..removeFirst();

    emit(
      state.copyWith(
        queue: updatedQueue,
        currentCommand: currentCommand,
        lastOutput: null,
        isActive: true,
      ),
    );

    FinishedBackupModel finishedBackup =
        FinishedBackupModel(command: currentCommand);

    await emit.forEach<ResticScriptingBaseType>(
      executor.executeCommand(currentCommand),
      onData: (data) {
        if (data is ResticReturnType) {
          finishedBackup = finishedBackup.copyWith(returnType: data);
        } else if (data is ResticBackupSummaryType) {
          finishedBackup = finishedBackup.copyWith(summaryType: data);
        } else if (data is ResticErrorType) {
          finishedBackup = finishedBackup.copyWith(errorType: data);
        } else if (data is ResticBaseErrorType) {
          finishedBackup = finishedBackup.copyWith(backupErrorType: data);
        }
        return state.copyWith(lastOutput: data);
      },
      // ToDo Do we need on error or is everything handled by the CommandExecutor?
    );

    // Ensure the "execution end" emit ist received
    await Future.delayed(Duration(milliseconds: 100));

    emit(
      state.copyWith(
        clearCurrentCommand: true,
        isActive: state.queue.isNotEmpty,
        finishedBackups: List<FinishedBackupModel>.from(state.finishedBackups)
          ..add(finishedBackup),
      ),
    );

    if (state.queue.isNotEmpty) {
      add(ProcessNext());
    }
  }

  void _onRemoveFinishedCommand(
      RemoveFinishedCommand event, Emitter<BackupQueueState> emit) {
    emit(
      state.copyWith(
        finishedBackups: List<FinishedBackupModel>.from(state.finishedBackups)
          ..removeWhere((element) => element.command == event.command),
      ),
    );
  }
}

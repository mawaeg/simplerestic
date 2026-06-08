import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../../backend/restic_command/base/restic_command.dart';
import '../../backend/restic_types/base/restic_scripting_base_type.dart';
import 'finished_backup_model.dart';

class BackupQueueState extends Equatable {
  final Queue<ResticCommand> queue;
  final ResticCommand? currentCommand;
  final ResticScriptingBaseType? lastOutput;
  final bool isActive;
  final List<FinishedBackupModel> finishedBackups;

  const BackupQueueState({
    required this.queue,
    this.currentCommand,
    this.lastOutput,
    this.isActive = false,
    this.finishedBackups = const [],
  });

  factory BackupQueueState.initial() {
    return BackupQueueState(queue: Queue<ResticCommand>());
  }

  BackupQueueState copyWith({
    Queue<ResticCommand>? queue,
    ResticCommand? currentCommand,
    ResticScriptingBaseType? lastOutput,
    bool? isActive,
    List<FinishedBackupModel>? finishedBackups,
    bool clearCurrentCommand = false,
  }) {
    return BackupQueueState(
      queue: queue ?? this.queue,
      currentCommand:
          clearCurrentCommand ? null : (currentCommand ?? this.currentCommand),
      lastOutput: clearCurrentCommand ? null : (lastOutput ?? this.lastOutput),
      isActive: isActive ?? this.isActive,
      finishedBackups: finishedBackups ?? this.finishedBackups,
    );
  }

  bool isCommandExecuting(ResticCommand command) {
    return currentCommand == command;
  }

  bool isCommandQueued(ResticCommand command) {
    return queue.contains(command);
  }

  bool isCommandAdded(ResticCommand command) {
    return isCommandExecuting(command) || isCommandQueued(command);
  }

  bool isCommandFinished(ResticCommand command) {
    int index =
        finishedBackups.indexWhere((element) => element.command == command);
    return index != -1;
  }

  @override
  List<Object?> get props =>
      [queue, currentCommand, lastOutput, isActive, finishedBackups];
}

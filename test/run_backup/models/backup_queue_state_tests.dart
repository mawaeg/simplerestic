import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command.dart';
import 'package:simplerestic/backend/restic_command/restic_command_backup.dart';
import 'package:simplerestic/run_backup/models/backup_queue_state.dart';
import 'package:simplerestic/run_backup/models/finished_backup_model.dart';

void main() {
  late BackupQueueState state;
  late ResticCommandBackup command;

  group("Test BackupQueueState", () {
    setUp(() {
      state = BackupQueueState.initial();
      command = ResticCommandBackup(
          repository: "testRepo",
          passwordFile: "testPassword",
          path: ["testPath"]);
    });

    test("Assert initial BackupQueueState", () {
      expect(state.queue.isEmpty, true);
      expect(state.currentCommand, null);
      expect(state.lastOutput, null);
      expect(state.isActive, false);
      expect(state.finishedBackups.isEmpty, true);
    });

    test("Assert isCommandExecuting works as expected.", () {
      expect(state.isCommandExecuting(command), false);
      state = state.copyWith(currentCommand: command);
      expect(state.isCommandExecuting(command), true);
    });

    test("Assert isCommandQueued works as expected.", () {
      expect(state.isCommandQueued(command), false);
      state = state.copyWith(queue: Queue.from(state.queue)..add(command));
      expect(state.isCommandQueued(command), true);
    });

    test("Assert isCommandAdded works as expected", () {
      expect(state.isCommandAdded(command), false);
      state = state.copyWith(queue: Queue.from(state.queue)..add(command));
      expect(state.isCommandAdded(command), true);
      state = state.copyWith(
        queue: Queue<ResticCommand>(),
        currentCommand: command,
      );
      expect(state.isCommandAdded(command), true);
    });

    test("Assert isCommandFinished works as expected", () {
      expect(state.isCommandFinished(command), false);
      FinishedBackupModel finishedBackup =
          FinishedBackupModel(command: command);
      state = state.copyWith(finishedBackups: [finishedBackup]);
      expect(state.isCommandFinished(command), true);
    });
  });
}

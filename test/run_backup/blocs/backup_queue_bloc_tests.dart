import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command.dart';
import 'package:simplerestic/backend/restic_command/restic_command_backup.dart';
import 'package:simplerestic/backend/restic_command_executor.dart';
import 'package:simplerestic/backend/restic_types/primitives/backup/restic_backup_summary_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/base/restic_base_error_type.dart';
import 'package:simplerestic/backend/restic_types/restic_error_type.dart';
import 'package:simplerestic/backend/restic_types/restic_return_type.dart';
import 'package:simplerestic/run_backup/blocs/backup_queue_bloc.dart';
import 'package:simplerestic/run_backup/models/backup_queue_event.dart';
import 'package:simplerestic/run_backup/models/backup_queue_state.dart';
import 'package:simplerestic/run_backup/models/finished_backup_model.dart';

class MockResticCommandExecutor extends Mock implements ResticCommandExecutor {}

class FakeResticCommand extends Fake implements ResticCommand {}

class FakeResticReturnType extends Fake implements ResticReturnType {}

class FakeResticBackupSummaryType extends Fake
    implements ResticBackupSummaryType {}

class FakeResticErrorType extends Fake implements ResticErrorType {}

class FakeResticBaseErrorType extends Fake implements ResticBaseErrorType {}

void main() {
  late MockResticCommandExecutor commandExecutorMock;
  late BackupQueueBloc backupQueueBloc;
  late ResticCommandBackup testCommand;
  late ResticCommandBackup testCommand2;

  late FakeResticReturnType fakeResticReturnType;
  late FakeResticBackupSummaryType sharedSummaryType;
  late FakeResticErrorType sharedErrorType;
  late FakeResticBaseErrorType sharedBaseErrorType;

  // Required by mocktail to use any() with custom classes
  setUpAll(() {
    registerFallbackValue(FakeResticCommand());
  });

  setUp(() {
    commandExecutorMock = MockResticCommandExecutor();
    backupQueueBloc = BackupQueueBloc(executor: commandExecutorMock);
    testCommand = ResticCommandBackup(
      repository: "testRepo",
      passwordFile: "testPassword",
      path: ["testPath"],
    );
    testCommand2 = ResticCommandBackup(
      repository: "testRepo2",
      passwordFile: "testPassword2",
      path: ["testPath2"],
    );

    fakeResticReturnType = FakeResticReturnType();
    sharedSummaryType = FakeResticBackupSummaryType();
    sharedErrorType = FakeResticErrorType();
    sharedBaseErrorType = FakeResticBaseErrorType();
  });

  void expectDefaultValues() {
    BackupQueueState initialState = BackupQueueState.initial();
    expect(backupQueueBloc.state, initialState);
  }

  group('BackupQueueBloc Tests', () {
    test("Initial state is empty", () {
      expectDefaultValues();
    });

    blocTest<BackupQueueBloc, BackupQueueState>(
      "Assert that AddCommand correctly updates the state and automatically executes the command",
      build: () {
        when(() => commandExecutorMock.executeCommand(any()))
            .thenAnswer((_) => Stream.fromIterable([
                  sharedSummaryType,
                  sharedErrorType,
                  sharedBaseErrorType,
                  fakeResticReturnType,
                ]));
        return backupQueueBloc;
      },
      act: (bloc) => bloc.add(AddCommand(testCommand)),
      wait: const Duration(
          milliseconds: 200), // Delay for frontend to catch all messages
      expect: () => [
        // Command added to Queue
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>()..add(testCommand),
        ),
        // ProcessNext triggered -> command active
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>(),
          currentCommand: testCommand,
          isActive: true,
          lastOutput: null,
        ),
        // Expect outputs returned by Stream
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>(),
          currentCommand: testCommand,
          isActive: true,
          lastOutput: sharedSummaryType,
        ),
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>(),
          currentCommand: testCommand,
          isActive: true,
          lastOutput: sharedErrorType,
        ),
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>(),
          currentCommand: testCommand,
          isActive: true,
          lastOutput: sharedBaseErrorType,
        ),
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>(),
          currentCommand: testCommand,
          isActive: true,
          lastOutput: fakeResticReturnType,
        ),
        // Backup finished, -> command not active anymore, added to finishedBackups
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>(),
          isActive: false,
          clearCurrentCommand: true,
          finishedBackups: [
            FinishedBackupModel(
              command: testCommand,
              summaryType: sharedSummaryType,
              errorType: sharedErrorType,
              backupErrorType: sharedBaseErrorType,
              returnType: fakeResticReturnType,
            )
          ],
        ),
      ],
    );

    blocTest<BackupQueueBloc, BackupQueueState>(
      "Assert that no new state is emitted when ProcessNext is called with empty queue",
      build: () => backupQueueBloc,
      act: (bloc) => bloc.add(ProcessNext()),
      expect: () => [],
    );

    blocTest<BackupQueueBloc, BackupQueueState>(
      "Assert that RemoveFinishedCommand removes the correct command from the finished list",
      build: () => backupQueueBloc,
      seed: () => BackupQueueState.initial().copyWith(
        finishedBackups: [
          FinishedBackupModel(command: testCommand),
          FinishedBackupModel(command: testCommand2)
        ],
      ),
      act: (bloc) => bloc.add(RemoveFinishedCommand(testCommand)),
      expect: () => [
        BackupQueueState.initial().copyWith(
          finishedBackups: [FinishedBackupModel(command: testCommand2)],
        ),
      ],
    );

    blocTest<BackupQueueBloc, BackupQueueState>(
      "Assert that finishing a command triggers the next one if queue is not empty",
      build: () {
        when(() => commandExecutorMock.executeCommand(any()))
            .thenAnswer((_) => Stream.empty());
        return backupQueueBloc;
      },
      seed: () => BackupQueueState.initial().copyWith(
        // Add two initial commands
        queue: Queue<ResticCommand>()
          ..add(testCommand)
          ..add(testCommand2),
      ),

      act: (bloc) => bloc.add(ProcessNext()),
      wait: const Duration(
          milliseconds: 500), // Wait long enough for two 100ms delays
      expect: () => [
        // Process first command
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>()..add(testCommand2),
          currentCommand: testCommand,
          isActive: true,
          lastOutput: null,
        ),
        // First command finishes, still active
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>()..add(testCommand2),
          isActive: true, // Still true!
          clearCurrentCommand: true,
          finishedBackups: [FinishedBackupModel(command: testCommand)],
        ),
        // Process second command
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>(),
          currentCommand: testCommand2,
          isActive: true,
          lastOutput: null,
          finishedBackups: [FinishedBackupModel(command: testCommand)],
        ),
        // Second command finishes, not active anymore
        BackupQueueState.initial().copyWith(
          queue: Queue<ResticCommand>(),
          isActive: false,
          clearCurrentCommand: true,
          finishedBackups: [
            FinishedBackupModel(command: testCommand),
            FinishedBackupModel(command: testCommand2),
          ],
        ),
      ],
    );
  });
}

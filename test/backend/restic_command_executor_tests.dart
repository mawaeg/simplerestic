import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/backend/restic_command/base/restic_command.dart';
import 'package:simplerestic/backend/restic_command/restic_command_cat_config.dart';
import 'package:simplerestic/backend/restic_command/restic_command_init.dart';
import 'package:simplerestic/backend/restic_command_executor.dart';
import 'package:simplerestic/backend/restic_types/base/restic_scripting_base_type.dart';
import 'package:simplerestic/backend/restic_types/primitives/init/restic_init_type.dart';
import 'package:simplerestic/backend/restic_types/restic_error_type.dart';
import 'package:simplerestic/backend/restic_types/restic_return_type.dart';
import 'package:simplerestic/common/utils/abstraction_layer.dart';

class ProcessRunnerMock extends Mock implements ProcessRunner {}

void main() {
  group(ResticCommandExecutor, () {
    late ResticCommand testCommand;
    late ProcessRunnerMock processRunnerMock;
    late ResticCommandExecutor executor;
    late Directory tempFolder;
    late File passwordFile;
    late Directory repoFolder;

    setUp(() async {
      // Prepare a temporary folder with a password file and a repository folder
      tempFolder = Directory.systemTemp.createTempSync();
      passwordFile =
          await File("${tempFolder.path}/testPasswordFile.txt").create();
      repoFolder = await Directory("${tempFolder.path}/testRepo").create();
      passwordFile.writeAsStringSync("testPassword");

      // Prepare the ResticCommandExecutor with a ResticCommandInit command
      testCommand = ResticCommandInit(
        repository: repoFolder.path,
        passwordFile: passwordFile.path,
      );
      processRunnerMock = ProcessRunnerMock();
      executor = ResticCommandExecutor(
        processRunner: processRunnerMock,
      );
    });

    tearDown(() {
      tempFolder.deleteSync(recursive: true);
    });

    test("Assert that startCommandProcessworks as expected", () {
      when(() => processRunnerMock.start(any(that: equals(resticPath)),
          any(that: equals(testCommand.build())))).thenAnswer(
        (_) => Future.value(Process.start("echo", ["test"])),
      );
      executor.startCommandProcess(testCommand);

      verify(() => processRunnerMock.start(resticPath, testCommand.build()))
          .called(1);
    });

    test("Assert that parseJson correctly parses a valid json", () {
      String rawJson =
          "{\"message_type\":\"initialized\",\"id\":\"testId\",\"repository\":\"testRepository\"}";
      ResticInitType testType = ResticInitType("testId", "testRepository");

      ResticScriptingBaseType? json = executor.parseJson(testCommand, rawJson);

      expect(json, testType);
    });

    test("Assert that pareJson returns Error type with invalid json", () {
      String rawJson =
          "{\"message_type\"initialized\",\"id\":\"testId\",\"repository\":\"testRepository\"";

      ResticScriptingBaseType? json = executor.parseJson(testCommand, rawJson);

      expect(json, isA<ResticErrorType>());
    });

    test("Assert that executeCommandAsync correctly executes a command",
        () async {
      // Here we want to run the real command, therefore we use the real ProcessRunner
      final ProcessRunner processRunner = ProcessRunner();

      when(() => processRunnerMock.start(resticPath, testCommand.build()))
          .thenAnswer(
        (_) => processRunner.start(resticPath, testCommand.build()),
      );

      List<ResticScriptingBaseType> output =
          await executor.executeCommandAsync(testCommand);

      expect(output, isNot(contains(isA<ResticErrorType>())));
      expect(
        output,
        containsAllInOrder([isA<ResticInitType>(), isA<ResticReturnType>()]),
      );
      expect(output.whereType<ResticReturnType>().first.exitCode, 0);
    });

    test(
        "Assert that executeCommandAsync correctly executes a command which raises an error during execution",
        () async {
      // Try to access a non existing repository, which should raise an error
      testCommand = ResticCommandCatConfig(
        repository: repoFolder.path,
        passwordFile: passwordFile.path,
      );

      executor = ResticCommandExecutor(
        processRunner: processRunnerMock,
      );

      // Here we want to run the real command, therefore we use the real ProcessRunner
      final ProcessRunner processRunner = ProcessRunner();

      when(() => processRunnerMock.start(resticPath, testCommand.build()))
          .thenAnswer(
        (_) => processRunner.start(resticPath, testCommand.build()),
      );

      List<ResticScriptingBaseType> output = [];

      await for (var data in executor.executeCommand(testCommand)) {
        output.add(data);
      }

      expect(
        output,
        containsAllInOrder([isA<ResticErrorType>(), isA<ResticReturnType>()]),
      );
      expect(output.whereType<ResticReturnType>().first.exitCode, 10);
    });
  });
}

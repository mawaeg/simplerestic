import 'dart:convert';
import 'dart:io';

import '../common/utils/abstraction_layer.dart';
import 'restic_command/base/restic_command.dart';
import 'restic_types/restic_error_type.dart';
import 'restic_types/restic_return_type.dart';
import 'restic_types/base/restic_scripting_base_type.dart';

const String resticPath = "assets/restic_0.18.1_linux_amd64";

class ResticCommandExecutor {
  final ProcessRunner processRunner;

  const ResticCommandExecutor({
    this.processRunner = const ProcessRunner(),
  });

  Future<Process> startCommandProcess(ResticCommand command) async {
    final process = await processRunner.start(
      resticPath,
      command.build(),
    );
    return process;
  }

  Stream<ResticScriptingBaseType> executeCommand(
    ResticCommand command, {
    bool returnTypeDelay = true,
  }) async* {
    final process = await startCommandProcess(command);
    await for (var data in process.stdout.transform(utf8.decoder)) {
      for (var json in data.split("\n")) {
        if (json.isNotEmpty) {
          ResticScriptingBaseType? resticJsonType = parseJson(command, json);
          if (resticJsonType != null) {
            yield resticJsonType;
          }
        }
      }
    }
    await for (var data in process.stderr.transform(utf8.decoder)) {
      //stderr is printed as plain text
      yield ResticErrorType(data);
    }

    // Yield the exit code of the process.
    var exitCode = await process.exitCode;
    //As the exit codes would be yielded directly after the last regular message, the StreamBuilder would always drop this message.
    if (returnTypeDelay) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    yield ResticReturnType(exitCode);

    return;
  }

  Future<List<ResticScriptingBaseType>> executeCommandAsync(
      ResticCommand command) async {
    List<ResticScriptingBaseType> output = [];
    await for (var data in executeCommand(command, returnTypeDelay: false)) {
      output.add(data);
    }

    return output;
  }

  ResticScriptingBaseType? parseJson(ResticCommand command, String rawJson) {
    dynamic json;
    try {
      json = jsonDecode(rawJson);
    } catch (e) {
      return ResticErrorType(e.toString());
    }
    // Call the commands json parser
    return command.parseJson(json);
  }
}

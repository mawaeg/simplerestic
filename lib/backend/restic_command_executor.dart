import 'dart:convert';
import 'dart:io';

import 'restic_command/base/restic_command.dart';
import 'restic_command/base/restic_command_type.dart';
import 'restic_types/restic_error_type.dart';
import 'restic_types/restic_return_type.dart';
import 'restic_types/base/restic_scripting_base_type.dart';

class ResticCommandExecutor {
  ResticCommand command;

  ResticCommandExecutor(this.command);

  static Future<Process> startCommandProcess(ResticCommand command) async {
    final process = await Process.start(
      "assets/restic_0.17.3_linux_amd64",
      command.build(),
    );
    return process;
  }

  Future<List<ResticScriptingBaseType>> executeCommandAsync() async {
    List<ResticScriptingBaseType> output = [];
    final process = await startCommandProcess(command);
    await for (var data in process.stdout.transform(utf8.decoder)) {
      if (command.type == ResticCommandType.cat) {
        // Cat command does not ose JSON lines -> extra handling needed :/
        ResticScriptingBaseType? resticJsonType = parseJson(data);
        if (resticJsonType != null) {
          output.add(resticJsonType);
        }
      } else {
        //We need to split the data by line because stream returns JSON lines
        for (var json in data.split("\n")) {
          if (json.isNotEmpty) {
            ResticScriptingBaseType? resticJsonType = parseJson(json);
            if (resticJsonType != null) {
              output.add(resticJsonType);
            }
          }
        }
      }
    }
    await for (var data in process.stderr.transform(utf8.decoder)) {
      //stderr is printed as plain text
      output.add(ResticErrorType(data));
    }

    // Yield the exit code of the process.
    var exitCode = await process.exitCode;
    output.add(ResticReturnType(exitCode));

    return output;
  }

  Stream<ResticScriptingBaseType> executeCommand() async* {
    final process = await startCommandProcess(command);
    await for (var data in process.stdout.transform(utf8.decoder)) {
      if (command.type == ResticCommandType.cat) {
        // Cat command does not ose JSON lines -> extra handling needed :/
        ResticScriptingBaseType? resticJsonType = parseJson(data);
        if (resticJsonType != null) {
          yield resticJsonType;
        }
      } else {
        //We need to split the data by line because stream returns JSON lines
        for (var json in data.split("\n")) {
          if (json.isNotEmpty) {
            ResticScriptingBaseType? resticJsonType = parseJson(json);
            if (resticJsonType != null) {
              yield resticJsonType;
            }
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
    await Future.delayed(Duration(milliseconds: 100));
    yield ResticReturnType(exitCode);

    return;
  }

  ResticScriptingBaseType? parseJson(String rawJson) {
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

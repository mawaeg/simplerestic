import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Purpose of this file is to abstract io functions to be able to properly mock them in the tests.
/// Therefore this file itself is not to be covered by the tests
// coverage:ignore-file

class PlatformChecker {
  const PlatformChecker();

  bool get isWindows {
    return Platform.isWindows;
  }

  bool get isLinux {
    return Platform.isLinux;
  }

  bool get isMacOS {
    return Platform.isMacOS;
  }
}

class ProcessRunner {
  const ProcessRunner();

  Future<void> run(String command, List<String> arguments) async {
    await Process.run(command, arguments);
  }

  Future<Process> start(String command, List<String> arguments) async {
    return await Process.start(command, arguments);
  }
}

class DirectoryPathProvider {
  const DirectoryPathProvider();

  Future<String> getApplicationDocumentsDirectoryPath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}

class DirectoryUtility {
  const DirectoryUtility();

  Future<void> create(String path) async {
    await Directory(path).create();
  }
}

class DateTimeUtility {
  const DateTimeUtility();

  DateTime getDateTimeNow() {
    return DateTime.now();
  }
}

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> openFolder(String path) async {
  if (Platform.isLinux) {
    await Process.run('xdg-open', [path]);
  } else if (Platform.isWindows) {
    await Process.run('explorer', [path]);
  }
}

Future<String> getMountPointPath(String folder, {bool create = false}) async {
  Directory dir = await getApplicationDocumentsDirectory();
  String mountPointPath = join(dir.path, folder);

  if (create) {
    await Directory(mountPointPath).create();
  }

  return mountPointPath;
}

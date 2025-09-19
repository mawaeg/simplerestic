import 'package:path/path.dart';

import 'abstraction_layer.dart';

class FolderUtils {
  final PlatformChecker platformChecker;
  final ProcessRunner processRunner;
  final DirectoryPathProvider directoryPathProvider;
  final DirectoryUtility directoryUtility;

  FolderUtils({
    this.platformChecker = const PlatformChecker(),
    this.processRunner = const ProcessRunner(),
    this.directoryPathProvider = const DirectoryPathProvider(),
    this.directoryUtility = const DirectoryUtility(),
  });

  Future<void> openFolder(String path) async {
    if (platformChecker.isLinux) {
      await processRunner.run('xdg-open', [path]);
    } else if (platformChecker.isWindows) {
      await processRunner.run('explorer', [path]);
    }
  }

  Future<String> getMountPointPath(String folder, {bool create = false}) async {
    String dir =
        await directoryPathProvider.getApplicationDocumentsDirectoryPath();
    String mountPointPath = join(dir, folder);

    if (create) {
      await directoryUtility.create(mountPointPath);
    }

    return mountPointPath;
  }
}

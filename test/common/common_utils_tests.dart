import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simplerestic/common/utils/abstraction_layer.dart';
import 'package:simplerestic/common/utils/date_time_to_string.dart';
import 'package:simplerestic/common/utils/folder_utils.dart';

class PlatformCheckerMock extends Mock implements PlatformChecker {}

class ProcessRunnerMock extends Mock implements ProcessRunner {}

class DirectoryPathProviderMock extends Mock implements DirectoryPathProvider {}

class DirectoryUtilityMock extends Mock implements DirectoryUtility {}

void main() {
  group("Test the common utils", () {
    test("Assert that dateTime2String correctly formats a DateTime", () {
      expect(dateTime2String(DateTime(2025, 2, 1, 12, 59)), "01.02.2025 12:59");
    });
  });

  group("Test the common folder utils", () {
    late PlatformCheckerMock platformChecker;
    late ProcessRunnerMock processRunner;
    late DirectoryPathProviderMock directoryPathProvider;
    late DirectoryUtilityMock directoryUtility;

    late FolderUtils folderUtils;

    setUp(() {
      platformChecker = PlatformCheckerMock();
      processRunner = ProcessRunnerMock();
      directoryPathProvider = DirectoryPathProviderMock();
      directoryUtility = DirectoryUtilityMock();

      folderUtils = FolderUtils(
        platformChecker: platformChecker,
        processRunner: processRunner,
        directoryPathProvider: directoryPathProvider,
        directoryUtility: directoryUtility,
      );
    });

    test("Assert that openFolder correctly opens folder on linux", () async {
      when(() => platformChecker.isLinux).thenReturn(true);

      when(() => processRunner.run(any(), any()))
          .thenAnswer((_) => Future.value());

      await folderUtils.openFolder("testPath");

      verify(() => processRunner.run("xdg-open", ["testPath"])).called(1);
    });

    test("Assert that openFolder correctly opens folder on windows", () async {
      when(() => platformChecker.isLinux).thenReturn(false);
      when(() => platformChecker.isWindows).thenReturn(true);

      when(() => processRunner.run(any(), any()))
          .thenAnswer((_) => Future.value());

      await folderUtils.openFolder("testPath");

      verify(() => processRunner.run("explorer", ["testPath"])).called(1);
    });

    Future<void> getMountPathTestFunc({bool create = false}) async {
      when(() => directoryPathProvider.getApplicationDocumentsDirectoryPath())
          .thenAnswer((_) => Future.value("test/path"));

      if (create) {
        when(() => directoryUtility.create(any()))
            .thenAnswer((_) => Future.value());
      }
      String result;
      if (!create) {
        result = await folderUtils.getMountPointPath("myFolderName");
      } else {
        result =
            await folderUtils.getMountPointPath("myFolderName", create: true);
      }

      if (create) {
        verify(() => directoryUtility.create("test/path/myFolderName"))
            .called(1);
      }

      expect(result, "test/path/myFolderName");
    }

    test(
        "Assert that getMountPointPath correctly retrieves the mount point path",
        () async {
      await getMountPathTestFunc();
    });

    test(
        "Assert that getMountPointPath correctly retrieves and creates the mount point path",
        () async {
      await getMountPathTestFunc(create: true);
    });
  });
}

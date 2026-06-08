import '../../backend/restic_command/restic_command_backup.dart';
import '../../common/models/repository_model.dart';

ResticCommandBackup buildBackupCommand(
  RepositoryModel repository,
  List<String> path, {
  bool dryRun = false,
}) {
  return ResticCommandBackup(
    repository: repository.path,
    passwordFile: repository.passwordFile,
    path: path,
    dryRun: dryRun,
  );
}

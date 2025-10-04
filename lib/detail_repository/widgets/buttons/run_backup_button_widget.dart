import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../backend/restic_command/restic_command_backup.dart';
import '../../../common/models/repository_model.dart';
import '../../../common/widgets/tap_to_copy_text.dart';
import '../../../run_backup/views/run_backup_alert_dialog.dart';

class RunBackupButtonWidget extends StatelessWidget {
  final RepositoryModel repository;
  final List<String> path;

  const RunBackupButtonWidget({
    super.key,
    required this.repository,
    required this.path,
  });

  ResticCommandBackup buildBackupCommand({bool dryRun = false}) {
    return ResticCommandBackup(
      repository: repository.path,
      passwordFile: repository.passwordFile,
      path: path,
      dryRun: dryRun,
    );
  }

  Future<void> showRunBackupAlertDialog(
    BuildContext context, {
    bool dryRun = false,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return RunBackupAlertDialog(
          backupCommand: buildBackupCommand(dryRun: dryRun),
          dryRun: dryRun,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return YaruSplitButton.outlined(
      onPressed: () async {
        await showRunBackupAlertDialog(context);
      },
      items: [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                YaruIcons.media_play,
                color: Theme.of(context).primaryColor,
              ),
              Text("Dry run"),
            ],
          ),
          onTap: () async {
            await showRunBackupAlertDialog(context, dryRun: true);
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                YaruIcons.copy,
                color: Theme.of(context).primaryColor,
              ),
              Text("Copy command"),
            ],
          ),
          onTap: () async {
            await onTapCopyAction(
              context,
              buildBackupCommand().build().join(" "),
              "backup command",
            );
          },
        ),
      ],
      child: Icon(YaruIcons.media_play, color: Theme.of(context).primaryColor),
    );
  }
}

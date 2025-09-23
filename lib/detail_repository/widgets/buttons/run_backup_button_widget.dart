import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../common/models/repository_model.dart';
import '../../../run_backup/views/run_backup_alert_dialog.dart';

class RunBackupButtonWidget extends StatelessWidget {
  final RepositoryModel repository;
  final List<String> path;

  const RunBackupButtonWidget({
    super.key,
    required this.repository,
    required this.path,
  });

  Future<void> showRunBackupAlertDialog(
    BuildContext context, {
    bool dryRun = false,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return RunBackupAlertDialog(
          repository: repository,
          path: path,
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
      ],
      child: Icon(YaruIcons.media_play, color: Theme.of(context).primaryColor),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../common/models/repository_model.dart';
import '../../../common/widgets/tap_to_copy_text.dart';
import '../../utils/build_backup_command.dart';
import '../../utils/show_run_backup_alert_dialog.dart';

class RunBackupButton extends StatelessWidget {
  final RepositoryModel repository;
  final List<String> path;

  const RunBackupButton(this.repository, this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      child: YaruSplitButton.outlined(
        onPressed: () async {
          await showRunBackupAlertDialog(context, repository, path);
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
              await showRunBackupAlertDialog(context, repository, path,
                  dryRun: true);
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
                buildBackupCommand(repository, path).build().join(" "),
                "backup command",
              );
            },
          ),
        ],
        child: Icon(
          YaruIcons.media_play,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../common/models/repository_model.dart';
import '../../utils/show_run_backup_alert_dialog.dart';

class BackupFinishedButton extends StatelessWidget {
  final RepositoryModel repository;
  final List<String> path;

  const BackupFinishedButton(this.repository, this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      child: YaruSplitButton.outlined(
        onPressed: () async {
          await showRunBackupAlertDialog(context, repository, path);
        },
        child: Icon(
          YaruIcons.monitor,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

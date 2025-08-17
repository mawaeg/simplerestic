import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../common/models/repository_model.dart';
import '../../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../../run_backup/views/run_backup_alert_dialog.dart';

class RunBackupButtonWidget extends StatelessWidget {
  final RepositoryModel repository;
  final String formattedPath;

  const RunBackupButtonWidget({
    super.key,
    required this.repository,
    required this.formattedPath,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return RunBackupAlertDialog(
              repository: repository,
              path: formattedPath,
            );
          },
        );
      },
      child: Icon(
        YaruIcons.media_play,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

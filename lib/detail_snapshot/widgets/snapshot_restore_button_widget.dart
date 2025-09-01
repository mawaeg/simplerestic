import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/models/repository_model.dart';
import '../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../restore_snapshot/views/snapshot_restore_alert_dialog.dart';

class SnapshotRestoreButtonWidget extends StatelessWidget {
  final RepositoryModel repository;
  final String id;
  const SnapshotRestoreButtonWidget({
    super.key,
    required this.repository,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Restore",
      child: SimpleResticYaruOptionButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return SnapshotRestoreAlertDialog(
                  repository: repository,
                  id: id,
                );
              });
        },
        child: const Icon(YaruIcons.undo),
      ),
    );
  }
}

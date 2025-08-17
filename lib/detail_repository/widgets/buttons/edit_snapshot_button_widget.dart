import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../common/models/repository_model.dart';
import '../../../common/models/snapshot_model.dart';
import '../../../common/widgets/simple_restic_yaru_option_button.dart';
import '../edit_snapshot_alert_dialog.dart';

class EditSnapshotButtonWidget extends StatelessWidget {
  final RepositoryModel repository;
  final List<String> path;
  final SnapshotModel? snapshot;

  const EditSnapshotButtonWidget({
    super.key,
    required this.repository,
    required this.path,
    this.snapshot,
  });
  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return EditSnapshotAlertDialog(
              repository: repository,
              snapshot: snapshot,
              path: path,
            );
          },
        );
      },
      child: const Icon(YaruIcons.settings),
    );
  }
}

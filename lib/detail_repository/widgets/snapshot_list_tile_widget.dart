import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/models/repository_model.dart';
import '../../common/models/snapshot_model.dart';
import '../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../run_backup/views/run_backup_alert_dialog.dart';
import 'edit_snapshot_alert_dialog.dart';

class SnapshotListTileWidget extends StatelessWidget {
  const SnapshotListTileWidget({
    super.key,
    required this.repository,
    required this.path,
    this.snapshot,
  });

  final RepositoryModel repository;
  final List<String> path;
  final SnapshotModel? snapshot;

  @override
  Widget build(BuildContext context) {
    String formattedPath = SnapshotModel.getPathListAsFormattedString(path);
    return YaruTile(
      title: Text(
        snapshot?.alias ?? formattedPath,
      ),
      subtitle: snapshot?.alias != null ? Text(formattedPath) : null,
      leading: SimpleResticYaruOptionButton(
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
      ),
      trailing: SimpleResticYaruOptionButton(
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
      ),
    );
  }
}

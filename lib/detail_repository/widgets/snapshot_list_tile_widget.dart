import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';
import '../../common/models/snapshot_model.dart';
import '../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../run_backup/views/run_backup_alert_dialog.dart';
import 'edit_snapshot_alert_dialog.dart';
import 'snapshot_list_tile_subtitle_widget.dart';

class SnapshotListTileWidget extends StatelessWidget {
  const SnapshotListTileWidget({
    super.key,
    required this.repository,
    required this.path,
    required this.snapshots,
    this.snapshot,
  });

  final RepositoryModel repository;
  final List<String> path;
  final List<ResticSnapshotsObjectType> snapshots;
  final SnapshotModel? snapshot;

  @override
  Widget build(BuildContext context) {
    String formattedPath = SnapshotModel.getPathListAsFormattedString(path);
    return YaruTile(
      title: Text(
        snapshot?.alias ?? formattedPath,
      ),
      subtitle: SnapshotListTileSubtitleWidget(
        formattedPath: formattedPath,
        snapshots: snapshots,
        repository: repository,
        snapshot: snapshot,
      ),
      // subtitle: snapshot?.alias != null
      //     ? Text("$formattedPath\n$lastBackup")
      //     : Text(lastBackup),
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

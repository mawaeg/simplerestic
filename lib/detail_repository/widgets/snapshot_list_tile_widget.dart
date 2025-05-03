import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/models/repository_model.dart';
import '../../common/widgets/simple_restic_yaru_option_button.dart';
import 'edit_snapshot_alert_dialog.dart';

class SnapshotListTileWidget extends StatelessWidget {
  const SnapshotListTileWidget({
    super.key,
    required this.alias,
    required this.snapshotPath,
    required this.model,
  });

  final String? alias;
  final String snapshotPath;
  final RepositoryModel model;

  @override
  Widget build(BuildContext context) {
    return YaruTile(
      title: Text(alias ?? snapshotPath),
      subtitle: alias != null ? Text(snapshotPath) : null,
      leading: SimpleResticYaruOptionButton(
        onPressed: null,
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
                repository: model,
                path: snapshotPath,
              );
            },
          );
        },
        child: const Icon(YaruIcons.settings),
      ),
    );
  }
}

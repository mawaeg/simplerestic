import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';
import '../../common/models/snapshot_model.dart';
import '../../common/widgets/mount_button_widget.dart';
import '../../common/widgets/tap_to_copy_text.dart';
import 'buttons/edit_snapshot_button_widget.dart';
import 'buttons/run_backup_button_widget.dart';
import 'buttons/snapshot_detail_button_widget.dart';
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
      title: TapToCopyText(
        text: snapshot?.alias ?? formattedPath,
        textToCopy: formattedPath,
        description: "path",
        tooltipMessage: snapshot?.alias != null ? formattedPath : null,
      ),
      subtitle: SnapshotListTileSubtitleWidget(
        formattedPath: formattedPath,
        snapshots: snapshots,
        repository: repository,
        snapshot: snapshot,
      ),
      leading: RunBackupButtonWidget(
        repository: repository,
        path: path,
      ),
      trailing: Row(
        children: [
          SnapshotDetailButtonWidget(
            repository: repository,
            formattedPath: formattedPath,
            snapshot: snapshot,
            snapshots: snapshots,
          ),
          MountButtonWidget(
            repository: repository.path,
            passwordFile: repository.passwordFile,
            path: path.join(" "),
          ),
          EditSnapshotButtonWidget(
            repository: repository,
            path: path,
            snapshot: snapshot,
          ),
        ],
      ),
    );
  }
}

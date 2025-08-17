import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/snapshot_model.dart';
import '../widgets/detail_snapshot_list_tile.dart';

class DetailSnapshotAlertDialog extends StatelessWidget {
  final String formattedPath;
  final SnapshotModel? snapshot;
  final List<ResticSnapshotsObjectType> snapshots;

  const DetailSnapshotAlertDialog({
    super.key,
    required this.formattedPath,
    this.snapshot,
    required this.snapshots,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text(snapshot?.alias ?? formattedPath),
        isClosable: true,
      ),
      content: SizedBox(
        height: 500,
        width: 500,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return DetailSnapshotListTile(
              snapshotObject: snapshots.reversed.toList()[index],
            );
          },
          itemCount: snapshots.length,
        ),
      ),
    );
  }
}

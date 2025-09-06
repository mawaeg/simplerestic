import 'package:flutter/material.dart';
import 'package:proper_filesize/proper_filesize.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';
import '../../common/utils/date_time_to_string.dart';
import '../../common/utils/shortened_id.dart';
import 'snapshot_forget_button_widget.dart';
import 'snapshot_restore_button_widget.dart';

class DetailSnapshotListTile extends StatelessWidget {
  final RepositoryModel repository;
  final ResticSnapshotsObjectType snapshotObject;

  const DetailSnapshotListTile({
    super.key,
    required this.repository,
    required this.snapshotObject,
  });

  @override
  Widget build(BuildContext context) {
    String fileSize =
        FileSize.fromBytes(snapshotObject.summary.totalBytesProcessed).toString(
      decimals: 2,
      unit: Unit.auto(
          size: snapshotObject.summary.totalBytesProcessed,
          baseType: BaseType.metric),
    );
    String id = getShortenedId(snapshotObject.id);
    String dateTime = dateTime2String(snapshotObject.time.toLocal());
    return YaruTile(
      title: Text("$id: $dateTime"),
      subtitle: Text("Host: ${snapshotObject.hostname} Size: $fileSize"),
      trailing: Row(
        children: [
          SnapshotRestoreButtonWidget(
            repository: repository,
            snapshotObject: snapshotObject,
          ),
          SnapshotForgetButtonWidget(
            repository: repository,
            id: snapshotObject.id,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../../common/models/snapshot_model.dart';
import '../../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../../detail_snapshot/views/detail_snapshot_alert_dialog.dart';

class SnapshotDetailButtonWidget extends StatelessWidget {
  final String formattedPath;
  final SnapshotModel? snapshot;
  final List<ResticSnapshotsObjectType> snapshots;

  const SnapshotDetailButtonWidget({
    super.key,
    required this.formattedPath,
    this.snapshot,
    required this.snapshots,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return DetailSnapshotAlertDialog(
              formattedPath: formattedPath,
              snapshot: snapshot,
              snapshots: snapshots,
            );
          },
        );
      },
      child: const Icon(YaruIcons.eye),
    );
  }
}

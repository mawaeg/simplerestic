import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../../common/cubits/snapshots_list_cubit.dart';
import '../../../common/models/repository_model.dart';
import '../../../common/models/snapshot_model.dart';
import '../../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../../detail_snapshot/views/detail_snapshot_alert_dialog.dart';

class SnapshotDetailButtonWidget extends StatelessWidget {
  final RepositoryModel repository;
  final String formattedPath;
  final SnapshotModel? snapshot;
  final List<ResticSnapshotsObjectType> snapshots;

  const SnapshotDetailButtonWidget({
    super.key,
    required this.repository,
    required this.formattedPath,
    this.snapshot,
    required this.snapshots,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () async {
        context.read<SnapshotsListCubit>().setSnapshots(snapshots);
        await showDialog(
          context: context,
          builder: (context) {
            return DetailSnapshotAlertDialog(
              repository: repository,
              formattedPath: formattedPath,
              snapshot: snapshot,
            );
          },
        );
      },
      child: const Icon(YaruIcons.eye),
    );
  }
}

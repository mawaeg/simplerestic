import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/cubits/snapshots_list_cubit.dart';
import '../../common/models/repository_model.dart';
import '../../common/models/snapshot_model.dart';
import '../widgets/detail_snapshot_list_tile.dart';

class DetailSnapshotAlertDialog extends StatelessWidget {
  final RepositoryModel repository;
  final String formattedPath;
  final SnapshotModel? snapshot;

  const DetailSnapshotAlertDialog({
    super.key,
    required this.repository,
    required this.formattedPath,
    this.snapshot,
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
        child: BlocBuilder<SnapshotsListCubit, List<ResticSnapshotsObjectType>>(
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return DetailSnapshotListTile(
                  repository: repository,
                  snapshotObject: state.reversed.toList()[index],
                );
              },
              itemCount: state.length,
            );
          },
        ),
      ),
    );
  }
}

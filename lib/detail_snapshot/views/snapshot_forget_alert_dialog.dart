import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/cubits/snapshot_rebuild_cubit.dart';
import '../../common/cubits/snapshots_list_cubit.dart';
import '../../common/models/repository_model.dart';
import '../cubits/prune_data_button_cubit.dart';
import 'snapshot_forget_running_alert_dialog.dart';

class SnapshotForgetAlertDialog extends StatelessWidget {
  final RepositoryModel repository;
  final ResticSnapshotsObjectType snapshot;

  const SnapshotForgetAlertDialog({
    super.key,
    required this.repository,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Forget ${snapshot.shortId}"),
        isClosable: true,
      ),
      content: SizedBox(
        height: 100,
        width: 200,
        child: BlocBuilder<PruneDataButtonCubit, bool>(
          builder: (context, state) {
            return Column(
              spacing: 20,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: state,
                      onChanged: (value) {
                        context.read<PruneDataButtonCubit>().set(value!);
                      },
                    ),
                    Text("Prune data"),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) =>
                          SnapshotForgetProgressIndicatorAlertDialog(
                        repository: repository,
                        snapshot: snapshot,
                      ),
                    );
                    if (context.mounted) {
                      context
                          .read<SnapshotsListCubit>()
                          .removeSnapshot(snapshot.id);
                      // Refresh snapshot list, so that the snapshot won't be shown when closing and reopening the detail view
                      // (When reopening, the SnapshotListCubit will be recreated based on the data fetched from restic)
                      context.read<SnapshotRebuildCubit>().toggle();
                      await Navigator.maybePop(context);
                    }
                  },
                  child: Text("Forget snapshot ${snapshot.shortId}"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

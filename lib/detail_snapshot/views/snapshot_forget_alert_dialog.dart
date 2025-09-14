import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_forget.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/cubits/snapshots_list_cubit.dart';
import '../../common/models/repository_model.dart';
import '../cubits/prune_data_button_cubit.dart';

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
                    await ResticCommandExecutor(
                      ResticCommandForget(
                        repository: repository.path,
                        passwordFile: repository.passwordFile,
                        snapshotId: snapshot.id,
                      ),
                    ).executeCommandAsync();
                    if (context.mounted) {
                      context
                          .read<SnapshotsListCubit>()
                          .removeSnapshot(snapshot.id);
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

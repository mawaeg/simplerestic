import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_forget.dart';
import '../../backend/restic_command_executor.dart';
import '../../common/cubits/snapshots_list_cubit.dart';
import '../../common/models/repository_model.dart';
import '../cubits/prune_data_button_cubit.dart';
import '../../common/utils/shortened_id.dart';

class SnapshotForgetAlertDialog extends StatelessWidget {
  final RepositoryModel repository;
  final String id;

  const SnapshotForgetAlertDialog({
    super.key,
    required this.repository,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final String shortenedId = getShortenedId(id);
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Forget $shortenedId"),
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
                        snapshotId: id,
                      ),
                    ).executeCommandAsync();
                    if (context.mounted) {
                      context.read<SnapshotsListCubit>().removeSnapshot(id);
                      await Navigator.maybePop(context);
                    }
                  },
                  child: Text("Forget snapshot $shortenedId"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

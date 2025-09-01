import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/restic_command/restic_command_restore.dart';
import '../../common/models/repository_model.dart';
import '../../common/utils/shortened_id.dart';
import '../cubits/restore_snapshot_cubit.dart';
import '../models/restore_snapshot_model.dart';
import '../views/snapshot_restore_status_alert_dialog.dart';

class SnapshotRestoreStartButtonWidget extends StatelessWidget {
  final String id;
  final RepositoryModel repository;
  final GlobalKey<FormState> formKey;

  const SnapshotRestoreStartButtonWidget({
    super.key,
    required this.formKey,
    required this.id,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestoreSnapshotCubit, RestoreSnapshotModel>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await showDialog(
                context: context,
                builder: (context) {
                  return SnapshotRestoreStatusAlertDialog(
                    id: id,
                    command: ResticCommandRestore(
                      repository: repository.path,
                      passwordFile: repository.passwordFile,
                      snapshotId: id,
                      target: state.target!, //ToDo Allow inplace restore
                      overwriteStrategy: state.overwriteStrategy,
                      delete: state.delete,
                    ),
                  );
                },
              );
              if (context.mounted) {
                context.read<RestoreSnapshotCubit>().clearData();
                await Navigator.maybePop(context);
              }
            }
          },
          child: Text("Restore snapshot ${getShortenedId(id)}"),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/restic_command/restic_command_restore.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';
import '../../common/utils/shortened_id.dart';
import '../cubits/restore_snapshot_cubit.dart';
import '../models/restore_snapshot_model.dart';
import '../views/snapshot_restore_status_alert_dialog.dart';

class SnapshotRestoreStartButtonWidget extends StatelessWidget {
  final ResticSnapshotsObjectType snapshotObject;
  final RepositoryModel repository;
  final GlobalKey<FormState> formKey;

  const SnapshotRestoreStartButtonWidget({
    super.key,
    required this.formKey,
    required this.snapshotObject,
    required this.repository,
  });
  // ToDo Add popup in case of inplace update
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
                  // As validators ensure inplace restore is only possible with only one path
                  // paths.first can be used here without any problems
                  return SnapshotRestoreStatusAlertDialog(
                    snapshotObject: snapshotObject,
                    command: ResticCommandRestore(
                      repository: repository.path,
                      passwordFile: repository.passwordFile,
                      snapshotId: snapshotObject.id,
                      target: state.target ?? snapshotObject.paths.first,
                      overwriteStrategy: state.overwriteStrategy,
                      delete: state.delete,
                      path: state.inplaceRestore
                          ? snapshotObject.paths.first
                          : null,
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
          child: Text("Restore snapshot ${getShortenedId(snapshotObject.id)}"),
        );
      },
    );
  }
}

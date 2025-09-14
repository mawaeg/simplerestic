import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/restic_command/base/restic_command_option_type.dart';
import '../../backend/restic_command/restic_command_restore.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';
import '../cubits/restore_snapshot_cubit.dart';
import '../models/restore_snapshot_model.dart';
import '../views/snapshot_restore_base_accept_dialog.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestoreSnapshotCubit, RestoreSnapshotModel>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              if (state.inplaceRestore) {
                await displayInplaceRestoreWarningDialog(context);
              } else if ((await Directory(state.target!).list().toList())
                      .isNotEmpty &&
                  (state.delete ||
                      state.overwriteStrategy !=
                          ResticOverwriteOptionTypeValues.never) &&
                  context.mounted) {
                await displayOverwriteWarningDialog(context);
              } else {
                context.read<RestoreSnapshotCubit>().setWarningsAccepted(true);
              }
              // To ensure you get the updated state after calling setWarningsAccepted,
              // you need to wait for the next build cycle. You can use addPostFrameCallback.
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                final updatedState = context.read<RestoreSnapshotCubit>().state;
                if (updatedState.warningsAccepted && context.mounted) {
                  await executeRestoreCommand(context, state);
                }
                if (context.mounted) {
                  context.read<RestoreSnapshotCubit>().clearData();
                  await Navigator.maybePop(context);
                }
              });
            }
          },
          child: Text("Restore snapshot ${snapshotObject.shortId}"),
        );
      },
    );
  }

  Future<void> displayInplaceRestoreWarningDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SnapshotRestoreBaseAcceptDialog(
          warning:
              "When performing an inplace restore, you should create a current backup beforehand. Otherwise files might be getting deleted or overwritten which are then not restorable.",
          snapshotObject: snapshotObject,
        );
      },
    );
  }

  Future<void> displayOverwriteWarningDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SnapshotRestoreBaseAcceptDialog(
          warning:
              "The folder you want to restore to is not empty. When using the delete option or an overwrite strategy different to never you might be deleting / overwriting files which might not be restorable.",
          snapshotObject: snapshotObject,
        );
      },
    );
  }

  Future<void> executeRestoreCommand(
      BuildContext context, RestoreSnapshotModel state) async {
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
            path: state.inplaceRestore ? snapshotObject.paths.first : null,
          ),
        );
      },
    );
  }
}

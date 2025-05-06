import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/cubits/snapshot_cubit.dart';
import '../../common/cubits/snapshot_rebuild_cubit.dart';
import '../../common/models/repository_model.dart';
import '../../common/models/snapshot_model.dart';
import '../../run_backup/views/run_backup_alert_dialog.dart';

class CreateSnapshotButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final RepositoryModel repository;
  final TextEditingController pathController;
  final TextEditingController aliasController;

  const CreateSnapshotButtonWidget({
    super.key,
    required this.formKey,
    required this.repository,
    required this.pathController,
    required this.aliasController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          if (aliasController.text.isNotEmpty) {
            context.read<SnapshotCubit>().addSnapshot(
                  SnapshotModel(
                    repositoryId: repository.id!,
                    path: pathController.text,
                    alias: aliasController.text,
                  ),
                );
          }

          await showDialog(
            context: context,
            builder: (context) {
              return RunBackupAlertDialog(
                repository: repository,
                path: pathController.text,
              );
            },
          );

          if (context.mounted) {
            // Refresh snapshot list to show newly created backup
            context.read<SnapshotRebuildCubit>().toggle();

            await Navigator.maybePop(context);
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text("Create"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_backup.dart';
import '../../common/cubits/snapshot_cubit.dart';
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

  Future<void> showRunBackupDialog(
    BuildContext context, {
    bool dryRun = false,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return RunBackupAlertDialog(
          backupCommand: ResticCommandBackup(
            repository: repository.path,
            passwordFile: repository.passwordFile,
            path: pathController.text.split(","),
          ),
          dryRun: dryRun,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return YaruSplitButton(
      items: [
        PopupMenuItem(
          child: Text("Dry run"),
          onTap: () async {
            if (formKey.currentState!.validate()) {
              await showRunBackupDialog(context, dryRun: true);
            }
          },
        ),
      ],
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          if (aliasController.text.isNotEmpty) {
            context.read<SnapshotCubit>().addSnapshot(
                  SnapshotModel(
                    repositoryId: repository.id!,
                    path: pathController.text.split(","),
                    alias: aliasController.text,
                  ),
                );
          }

          await showRunBackupDialog(context);

          if (context.mounted) {
            await Navigator.maybePop(context);
          }
        }
      },
      child: Text("Create"),
    );
  }
}

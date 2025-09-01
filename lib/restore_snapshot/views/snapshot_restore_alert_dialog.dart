import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/models/repository_model.dart';
import '../cubits/restore_snapshot_cubit.dart';
import '../../common/utils/shortened_id.dart';
import '../widgets/snapshot_restore_delete_checkbox_widget.dart';
import '../widgets/snapshot_restore_overwrite_strategy_widget.dart';
import '../widgets/snapshot_restore_path_text_field_widget.dart';
import '../widgets/snapshot_restore_start_button_widget.dart';

class SnapshotRestoreAlertDialog extends StatelessWidget {
  final RepositoryModel repository;
  final String id;

  const SnapshotRestoreAlertDialog({
    super.key,
    required this.repository,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Restore ${getShortenedId(id)}"),
        isClosable: true,
        onClose: (p0) async {
          context.read<RestoreSnapshotCubit>().clearData();
          await Navigator.maybePop(context);
        },
      ),
      content: SizedBox(
        height: 252,
        width: 400,
        child: Form(
          key: formKey,
          child: Column(
            spacing: 10,
            children: [
              SnapshotRestorePathTextFieldWidget(),
              SnapshotRestoreOverwriteStrategyWidget(),
              SnapshotRestoreDeleteCheckboxWidget(),
              SnapshotRestoreStartButtonWidget(
                formKey: formKey,
                id: id,
                repository: repository,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

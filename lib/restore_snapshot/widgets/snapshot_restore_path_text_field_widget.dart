import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/path_text_field_base_widget.dart';
import '../cubits/restore_snapshot_cubit.dart';

class SnapshotRestorePathTextFieldWidget extends StatelessWidget {
  const SnapshotRestorePathTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PathTextFieldBaseWidget(
      description: "The path where the snapshot should be restored to ",
      hintText: "Target path",
      required: false,
      readOnly: false,
      validator: (value) {
        if (value != "" && !Directory(value!).existsSync()) {
          return "The path to the folder must be valid or None.";
        }
        return null;
      },
      onValueChangedHook: context.read<RestoreSnapshotCubit>().setTarget,
    );
  }
}

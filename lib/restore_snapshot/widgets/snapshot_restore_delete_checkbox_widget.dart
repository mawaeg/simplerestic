import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/restore_snapshot_cubit.dart';
import '../models/restore_snapshot_model.dart';

class SnapshotRestoreDeleteCheckboxWidget extends StatelessWidget {
  const SnapshotRestoreDeleteCheckboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestoreSnapshotCubit, RestoreSnapshotModel>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: state.delete,
              onChanged: (value) {
                context.read<RestoreSnapshotCubit>().setDelete(value!);
              },
            ),
            Text("Delete data not existing in snapshot"),
          ],
        );
      },
    );
  }
}

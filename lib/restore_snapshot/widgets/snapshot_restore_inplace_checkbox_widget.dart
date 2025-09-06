import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../cubits/restore_snapshot_cubit.dart';
import '../models/restore_snapshot_model.dart';

class SnapshotRestoreInplaceCheckboxWidget extends StatelessWidget {
  final ResticSnapshotsObjectType snapshotObject;

  const SnapshotRestoreInplaceCheckboxWidget({
    super.key,
    required this.snapshotObject,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestoreSnapshotCubit, RestoreSnapshotModel>(
      builder: (context, state) {
        return FormField<bool>(
          builder: (formState) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: state.inplaceRestore,
                      onChanged: (value) {
                        context
                            .read<RestoreSnapshotCubit>()
                            .setInplaceRestore(value!);
                        formState.didChange(value);
                      },
                    ),
                    Text("Perform an inplace restore."),
                  ],
                ),
                if (formState.hasError)
                  Text(
                    formState.errorText!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            );
          },
          // Only allow inplace restoring when only one folder is backed up by a snapshot.
          // Otherwise it is not possible to correctly perform an inplace restore.
          validator: (value) {
            if (value == true && snapshotObject.paths.length > 1) {
              return "Inplace restore is only possible if the snapshot contains exactly one path.";
            }
            return null;
          },
        );
      },
    );
  }
}

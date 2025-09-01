import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/base/restic_command_option_type.dart';
import '../cubits/restore_snapshot_cubit.dart';
import '../models/restore_snapshot_model.dart';

class SnapshotRestoreOverwriteStrategyWidget extends StatelessWidget {
  const SnapshotRestoreOverwriteStrategyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestoreSnapshotCubit, RestoreSnapshotModel>(
      builder: (context, state) {
        return Column(
          spacing: 10,
          children: [
            Text("Overwrite Strategy"),
            DropdownMenu<ResticOverwriteOptionTypeValues>(
              trailingIcon: Icon(YaruIcons.pan_down),
              selectedTrailingIcon: Icon(YaruIcons.pan_down),
              initialSelection: state.overwriteStrategy,
              dropdownMenuEntries: ResticOverwriteOptionTypeValues.values
                  .map((ResticOverwriteOptionTypeValues value) {
                return DropdownMenuEntry(
                  value: value,
                  label: value.name.replaceAll("_", " "),
                );
              }).toList(),
              onSelected: (value) {
                if (value != null) {
                  context
                      .read<RestoreSnapshotCubit>()
                      .setOverwriteStrategy(value);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../cubits/restore_snapshot_cubit.dart';

class SnapshotRestoreBaseAcceptDialog extends StatelessWidget {
  final String warning;
  final ResticSnapshotsObjectType snapshotObject;

  const SnapshotRestoreBaseAcceptDialog({
    super.key,
    required this.warning,
    required this.snapshotObject,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Restore ${snapshotObject.shortId}"),
        isClosable: true,
        onClose: (p0) async {
          await Navigator.maybePop(context);
        },
      ),
      content: SizedBox(
        height: 150,
        width: 400,
        child: Column(
          spacing: 10,
          children: [
            Text("Warning: $warning"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    await Navigator.maybePop(context);
                  },
                  child: Text(
                    "Abort",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    context
                        .read<RestoreSnapshotCubit>()
                        .setWarningsAccepted(true);
                    await Navigator.maybePop(context);
                  },
                  child: Text("Continue (I know the risks)"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

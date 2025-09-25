import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_forget.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/primitives/snapshots/restic_snapshots_object_type.dart';
import '../../common/models/repository_model.dart';

class SnapshotForgetProgressIndicatorAlertDialog extends StatelessWidget {
  final RepositoryModel repository;
  final ResticSnapshotsObjectType snapshot;

  const SnapshotForgetProgressIndicatorAlertDialog({
    super.key,
    required this.repository,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Forgeting ${snapshot.shortId}"),
        isClosable: false,
      ),
      content: SizedBox(
          height: 100,
          width: 200,
          child: FutureBuilder(
              future: ResticCommandExecutor().executeCommandAsync(
                ResticCommandForget(
                  repository: repository.path,
                  passwordFile: repository.passwordFile,
                  snapshotId: snapshot.id,
                ),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Navigator.pop(context);
                }
                return Center(child: YaruCircularProgressIndicator());
              })),
    );
  }
}

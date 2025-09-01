import 'package:flutter/material.dart';

import '../../backend/restic_types/restic_return_type.dart';

class SnapshotRestoreFailedWidget extends StatelessWidget {
  final String error;
  final ResticReturnType returnType;

  const SnapshotRestoreFailedWidget({
    super.key,
    required this.error,
    required this.returnType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Restoring finished with exit code ${returnType.exitCode}"),
        Text("Restore execution failed with the following error:"),
        Text(error),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/models/repository_model.dart';
import '../../common/widgets/simple_restic_yaru_option_button.dart';
import '../views/snapshot_forget_alert_dialog.dart';

class SnapshotForgetButtonWidget extends StatelessWidget {
  final RepositoryModel repository;
  final String id;

  const SnapshotForgetButtonWidget({
    super.key,
    required this.repository,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Forget",
      child: SimpleResticYaruOptionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return SnapshotForgetAlertDialog(repository: repository, id: id);
            },
          );
        },
        child: const Icon(YaruIcons.trash),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../common/models/repository_model.dart';
import '../../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../../create_snapshot/views/create_snapshot_alert_dialog.dart';

class CreateNewSnapshotButtonWidget extends StatelessWidget {
  final RepositoryModel repository;

  const CreateNewSnapshotButtonWidget({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return CreateSnapshotAlertDialog(repository: repository);
          },
        );
      },
      child: const Icon(YaruIcons.plus),
    );
  }
}

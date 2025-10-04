import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../check_repository/views/check_repository_alert_dialog.dart';
import '../../../common/models/repository_model.dart';
import '../../../common/widgets/simple_restic_yaru_option_button.dart';

class CheckRepositoryButton extends StatelessWidget {
  final RepositoryModel repository;

  const CheckRepositoryButton({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Run repository check",
      child: SimpleResticYaruOptionButton(
        onPressed: () async {
          // ToDo Add Alert Dialog to run check command and display the results
          await showDialog(
              context: context,
              builder: (context) {
                return CheckRepositoryAlertDialog(repository: repository);
              });
        },
        child: const Icon(YaruIcons.health),
      ),
    );
  }
}

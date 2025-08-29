import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../../create_repository/view/create_repository_alert_dialog.dart';

class CreateRepositoryButtonWidget extends StatelessWidget {
  const CreateRepositoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return CreateRepositoryAlertDialog();
          },
        );
      },
      child: const Icon(YaruIcons.plus),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import 'simple_restic_yaru_option_button.dart';
import 'mount_alert_dialog.dart';

class MountButtonWidget extends StatelessWidget {
  final String repository;
  final String passwordFile;
  final dynamic path;

  const MountButtonWidget({
    super.key,
    required this.repository,
    required this.passwordFile,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return MountAlertDialog(
              repository: repository,
              passwordFile: passwordFile,
              path: path,
            );
          },
        );
      },
      child: const Icon(YaruIcons.folder_simple),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/widgets/simple_restic_yaru_option_button.dart';

class SnapshotRestoreButtonWidget extends StatelessWidget {
  const SnapshotRestoreButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Restore",
      child: SimpleResticYaruOptionButton(
        onPressed: () {},
        child: const Icon(YaruIcons.undo),
      ),
    );
  }
}

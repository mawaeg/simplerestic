import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/widgets/simple_restic_yaru_option_button.dart';

class SnapshotMountButtonWidget extends StatelessWidget {
  const SnapshotMountButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Mount",
      child: SimpleResticYaruOptionButton(
        onPressed: () {},
        child: const Icon(YaruIcons.eye),
      ),
    );
  }
}

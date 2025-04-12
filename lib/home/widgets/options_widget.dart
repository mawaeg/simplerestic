import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/widgets/simple_restic_yaru_option_button.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () {},
      child: const Icon(YaruIcons.menu),
    );
  }
}

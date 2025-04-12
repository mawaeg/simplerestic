import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../create_repository/view/create_repository_page.dart';

class CreateRepositoryWidget extends StatelessWidget {
  const CreateRepositoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleResticYaruOptionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CreateRepositoryPage()),
        );
      },
      child: const Icon(YaruIcons.plus),
    );
  }
}

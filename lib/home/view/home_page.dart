import 'package:flutter/material.dart';
import 'package:simplerestic/home/widgets/options_widget.dart';
import 'package:yaru/yaru.dart';

import '../widgets/create_repository_widget.dart';
import 'repository_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YaruWindowTitleBar(
        title: const Text("SimpleRestic"),
        backgroundColor: Colors.transparent,
        leading: Center(child: CreateRepositoryWidget()),
        actions: [OptionsWidget()],
      ),
      body: RepositoryListView(),
    );
  }
}

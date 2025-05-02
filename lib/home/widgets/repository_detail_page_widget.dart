import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import 'create_repository_widget.dart';

class RepositoryDetailPageWidget extends StatelessWidget {
  final String path;
  final String? alias;

  const RepositoryDetailPageWidget({
    super.key,
    required this.path,
    this.alias,
  });

  @override
  Widget build(BuildContext context) {
    return YaruDetailPage(
      appBar: YaruWindowTitleBar(
        title: Text(alias ?? path),
        backgroundColor: Colors.transparent,
        leading: Center(child: CreateRepositoryWidget()),
      ),
      body: Center(
        child: Text(alias ?? path),
      ),
    );
  }
}

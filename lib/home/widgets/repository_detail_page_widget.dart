import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../detail_repository/views/snapshot_list_view.dart';
import 'create_repository_widget.dart';

class RepositoryDetailPageWidget extends StatelessWidget {
  final String path;
  final String? alias;
  final String passwordFile;

  const RepositoryDetailPageWidget({
    super.key,
    required this.path,
    required this.passwordFile,
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
      body: SnapshotListView(
        path: path,
        alias: alias,
        passwordFile: passwordFile,
      ),
    );
  }
}

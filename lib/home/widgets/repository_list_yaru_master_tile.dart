import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class RepositoryListYaruMasterTile extends StatelessWidget {
  final String path;
  final String? alias;

  const RepositoryListYaruMasterTile({
    super.key,
    required this.path,
    required this.alias,
  });
  @override
  Widget build(BuildContext context) {
    return YaruMasterTile(
      title: Text(
        alias ?? path,
      ),
      subtitle: alias != null ? Text(path) : null,
    );
  }
}

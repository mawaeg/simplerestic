import 'package:flutter/material.dart';

import '../utils/folder_utils.dart';

class OpenFolderButtonWidget extends StatelessWidget {
  final String path;
  final Future<String> Function(String)? asyncPathModifierHook;

  const OpenFolderButtonWidget({
    super.key,
    required this.path,
    this.asyncPathModifierHook,
  });

  @override
  Widget build(BuildContext context) {
    String folderPath = path;
    return ElevatedButton(
      onPressed: () async {
        if (asyncPathModifierHook != null) {
          folderPath = await asyncPathModifierHook!(path);
        }
        await openFolder(folderPath);
      },
      child: Text("Open folder"),
    );
  }
}

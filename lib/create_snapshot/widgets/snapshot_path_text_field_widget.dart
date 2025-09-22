import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../create_repository/widgets/base_text_field_widget.dart';

class SnapshotPathTextFieldWidget extends StatefulWidget {
  final TextEditingController _pathController;
  const SnapshotPathTextFieldWidget(
      {super.key, required TextEditingController pathController})
      : _pathController = pathController;

  @override
  State<SnapshotPathTextFieldWidget> createState() =>
      _SnapshotPathTextFieldWidgetState();
}

class _SnapshotPathTextFieldWidgetState
    extends State<SnapshotPathTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseTextFieldWidget(
      description: "The path you want to create a snapshot for.",
      hintText: "Split multiple paths with \",\"",
      controller: widget._pathController,
      suffixIcon: YaruIconButton(
        onPressed: () async {
          String? selectedDirectory =
              await FilePicker.platform.getDirectoryPath();
          if (selectedDirectory != null) {
            setState(() {
              widget._pathController.text = selectedDirectory;
            });
          }
        },
        icon: Icon(YaruIcons.folder),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Path is required.";
        }
        List<String> paths = value.split(",");
        for (String path in paths) {
          if (!Directory(path).existsSync()) {
            return "The path(s) to the folder(s) must be valid.";
          }
        }
        return null;
      },
    );
  }
}

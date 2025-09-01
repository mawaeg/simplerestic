import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../create_repository/widgets/base_text_field_widget.dart';

class PathTextFieldBaseWidget extends StatefulWidget {
  final String description;
  final String hintText;
  final bool required;
  final bool readOnly;
  final String? initialValue;
  final String? Function(String? value)? validator;
  final void Function(String value)? onValueChangedHook;

  const PathTextFieldBaseWidget({
    super.key,
    required this.description,
    required this.hintText,
    required this.required,
    required this.readOnly,
    this.initialValue,
    this.validator,
    this.onValueChangedHook,
  });

  @override
  State<StatefulWidget> createState() => _PathTextFieldBaseWidgetState();
}

class _PathTextFieldBaseWidgetState extends State<PathTextFieldBaseWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    if (widget.initialValue != null) {
      widget.onValueChangedHook!(widget.initialValue!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTextFieldWidget(
      description: widget.description,
      hintText: widget.hintText,
      controller: _controller,
      suffixIcon: YaruIconButton(
        icon: Icon(YaruIcons.folder),
        onPressed: () async {
          String? selectedDirectory =
              await FilePicker.platform.getDirectoryPath();
          if (selectedDirectory != null) {
            setState(() {
              _controller.text = selectedDirectory;
            });
            if (widget.onValueChangedHook != null) {
              widget.onValueChangedHook!(selectedDirectory);
            }
          }
        },
      ),
      onChanged: widget.onValueChangedHook,
      readOnly: widget.readOnly,
      validator: widget.validator,
    );
  }
}

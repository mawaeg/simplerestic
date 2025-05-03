import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../cubits/create_repository_cubit.dart';
import 'base_text_field_widget.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final String? initialValue;
  const PasswordTextFieldWidget({
    super.key,
    this.initialValue,
  });

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  late TextEditingController _passwordFileController;

  @override
  void initState() {
    super.initState();
    _passwordFileController = TextEditingController(text: widget.initialValue);
    if (widget.initialValue != null) {
      context
          .read<CreateRepositoryCubit>()
          .setPasswordFile(widget.initialValue);
    }
  }

  @override
  void dispose() {
    _passwordFileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void setPasswordFile(String passwordFile) {
      if (context.mounted) {
        context.read<CreateRepositoryCubit>().setPasswordFile(passwordFile);
      }
    }

    return BaseTextFieldWidget(
      description: "The path to the password file for the repository.",
      hintText: "Password file",
      controller: _passwordFileController,
      suffixIcon: YaruIconButton(
        onPressed: () async {
          FilePickerResult? filePickerResult =
              await FilePicker.platform.pickFiles(allowedExtensions: ["txt"]);
          if (filePickerResult != null && filePickerResult.files.length == 1) {
            setState(() {
              _passwordFileController.text = filePickerResult.files.first.path!;
            });
            setPasswordFile(filePickerResult.files.first.path!);
          }
        },
        icon: Icon(YaruIcons.folder),
      ),
      onChanged: setPasswordFile,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "PasswordFile is required";
        }
        if (!File(value).existsSync()) {
          return "Path to password file must be valid!";
        }
        return null;
      },
    );
  }
}

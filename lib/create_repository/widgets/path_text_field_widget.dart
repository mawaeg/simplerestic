import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_list_cubit.dart';
import '../../common/models/repository_list_model.dart';
import '../cubits/create_repository_cubit.dart';
import 'base_text_field_widget.dart';

class PathTextFieldWidget extends StatefulWidget {
  const PathTextFieldWidget({super.key});

  @override
  State<PathTextFieldWidget> createState() => _PathTextFieldWidgetState();
}

class _PathTextFieldWidgetState extends State<PathTextFieldWidget> {
  late TextEditingController _pathController;

  @override
  void initState() {
    super.initState();
    _pathController = TextEditingController();
  }

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void setPath(String path) {
      if (context.mounted) {
        context.read<CreateRepositoryCubit>().setPath(path);
      }
    }

    return BlocBuilder<RepositoryListCubit, RepositoryListModel>(
        builder: (context, state) {
      return BaseTextFieldWidget(
        description: "The path to the repository you want to create / import.",
        hintText: "Path",
        controller: _pathController,
        suffixIcon: YaruIconButton(
          onPressed: () async {
            String? selectedDirectory =
                await FilePicker.platform.getDirectoryPath();
            if (selectedDirectory != null) {
              setState(() {
                _pathController.text = selectedDirectory;
              });
              setPath(selectedDirectory);
            }
          },
          icon: Icon(YaruIcons.folder),
        ),
        onChanged: setPath,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Path is required.";
          }
          if (state.repositoryExistsByPath(value)) {
            return "Repository can only be added once.";
          }
          if (!Directory(value).existsSync()) {
            return "The path to the folder must be valid.";
          }
          return null;
        },
      );
    });
  }
}

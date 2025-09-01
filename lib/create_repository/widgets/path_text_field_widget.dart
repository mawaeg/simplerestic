import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/cubits/repository_cubit.dart';
import '../../common/models/repository_model.dart';
import '../../common/widgets/path_text_field_base_widget.dart';
import '../cubits/create_repository_cubit.dart';

class PathTextFieldWidget extends StatelessWidget {
  final bool readOnly;
  final String? initialValue;

  const PathTextFieldWidget({
    super.key,
    required this.readOnly,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryCubit, List<RepositoryModel>>(
      builder: (context, state) {
        return PathTextFieldBaseWidget(
          description:
              "The path to the repository you want to create / import.",
          hintText: "Path",
          required: true,
          readOnly: readOnly,
          initialValue: initialValue,
          onValueChangedHook: context.read<CreateRepositoryCubit>().setPath,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Path is required.";
            }
            if (state.any((element) => element.path == value) && !readOnly) {
              return "Repository can only be added once.";
            }
            if (!Directory(value).existsSync()) {
              return "The path to the folder must be valid.";
            }
            return null;
          },
        );
      },
    );
  }
}

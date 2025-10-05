import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/create_repository_cubit.dart';
import 'base_text_field_widget.dart';

class AliasTextFieldWidget extends StatefulWidget {
  final String? initialValue;
  const AliasTextFieldWidget({super.key, this.initialValue});

  @override
  State<AliasTextFieldWidget> createState() => _AliasTextFieldWidgetState();
}

class _AliasTextFieldWidgetState extends State<AliasTextFieldWidget> {
  late TextEditingController _aliasController;

  @override
  void initState() {
    super.initState();
    _aliasController = TextEditingController(text: widget.initialValue);
    if (widget.initialValue != null) {
      context.read<CreateRepositoryCubit>().setAlias(widget.initialValue);
    }
  }

  @override
  void dispose() {
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void setAlias(String alias) {
      if (context.mounted) {
        context
            .read<CreateRepositoryCubit>()
            .setAlias(alias != "" ? alias : null);
      }
    }

    return BaseTextFieldWidget(
      description: "An optional alias you want to assign to the repository.",
      hintText: "Alias",
      controller: _aliasController,
      onChanged: setAlias,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/models/repository_model.dart';
import '../cubits/create_repository_cubit.dart';
import '../widgets/alias_text_field_widget.dart';
import '../widgets/create_repository_button_widget.dart';
import '../widgets/password_text_field_widget.dart';
import '../widgets/path_text_field_widget.dart';
import '../widgets/repository_interval_select_text_field_widget.dart';

class CreateRepositoryAlertDialog extends StatelessWidget {
  final bool create;
  final RepositoryModel? repository;
  final _formKey = GlobalKey<FormState>();

  CreateRepositoryAlertDialog({
    super.key,
    this.create = true,
    this.repository,
  }) : assert(create || repository != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text(create ? "Add a new repository" : "Update repository"),
        isClosable: true,
        onClose: (context) {
          context.read<CreateRepositoryCubit>().clear();
          Navigator.maybePop(context);
        },
      ),
      content: SizedBox(
        height: 391,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PathTextFieldWidget(
                readOnly: !create,
                initialValue: !create ? repository!.path : null,
              ),
              PasswordTextFieldWidget(
                initialValue: !create ? repository!.passwordFile : null,
              ),
              AliasTextFieldWidget(
                initialValue: !create ? repository!.alias : null,
              ),
              RepositoryIntervalSelectTextFieldWidget(
                initialInterval: !create ? repository!.snapshotInterval : null,
              ),
              CreateRepositoryButtonWidget(
                formKey: _formKey,
                create: create,
                repository: repository,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

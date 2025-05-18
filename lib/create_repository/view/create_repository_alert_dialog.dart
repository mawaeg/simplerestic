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

//ToDo make StatelessWidget (working in create snapshot)
class CreateRepositoryAlertDialog extends StatefulWidget {
  final bool create;
  final RepositoryModel? repository;
  const CreateRepositoryAlertDialog({
    super.key,
    this.create = true,
    this.repository,
  }) : assert(create || repository != null);

  @override
  State<CreateRepositoryAlertDialog> createState() =>
      _CreateRepositoryAlertDialogState();
}

class _CreateRepositoryAlertDialogState
    extends State<CreateRepositoryAlertDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title:
            Text(widget.create ? "Add a new repository" : "Update repository"),
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
                readOnly: !widget.create,
                initialValue: !widget.create ? widget.repository!.path : null,
              ),
              PasswordTextFieldWidget(
                initialValue:
                    !widget.create ? widget.repository!.passwordFile : null,
              ),
              AliasTextFieldWidget(
                initialValue: !widget.create ? widget.repository!.alias : null,
              ),
              RepositoryIntervalSelectTextFieldWidget(
                initialInterval:
                    !widget.create ? widget.repository!.snapshotInterval : null,
              ),
              CreateRepositoryButtonWidget(
                formKey: _formKey,
                create: widget.create,
                repository: widget.repository,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

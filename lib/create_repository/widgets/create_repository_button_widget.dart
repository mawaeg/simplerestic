import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/cubits/repository_cubit.dart';
import '../../common/models/repository_model.dart';
import '../cubits/create_repository_cubit.dart';
import '../models/create_repository_model.dart';
import 'alert_dialogs/check_repository_existing_alert_dialog.dart';

class CreateRepositoryButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final bool create;
  final RepositoryModel? repository;

  const CreateRepositoryButtonWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.create,
    this.repository,
  }) : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateRepositoryCubit, CreateRepositoryModel>(
        builder: (context, state) {
      return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await showDialog(
              context: context,
              builder: (context) {
                return CheckRepositoryExistingAlertDialog();
              },
            );
            if (state.isSuccessful && context.mounted) {
              if (create) {
                context.read<RepositoryCubit>().addRepository(
                      RepositoryModel(
                        path: state.path!,
                        passwordFile: state.passwordFile!,
                        alias: state.alias,
                      ),
                    );
              } else {
                context.read<RepositoryCubit>().updateRepository(
                      repository!
                        ..passwordFile = state.passwordFile!
                        ..alias = state.alias,
                    );
              }

              context.read<CreateRepositoryCubit>().clear();
              return Navigator.of(context).pop();
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(create ? "Add" : "Update"),
      );
    });
  }
}

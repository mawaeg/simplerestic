import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_list_cubit.dart';
import '../../common/models/repository_model.dart';
import '../cubits/create_repository_cubit.dart';
import '../models/create_repository_model.dart';
import '../widgets/alias_text_field_widget.dart';
import '../widgets/alert_dialogs/check_repository_existing_alert_dialog.dart';
import '../widgets/password_text_field_widget.dart';
import '../widgets/path_text_field_widget.dart';

class CreateRepositoryPage extends StatefulWidget {
  const CreateRepositoryPage({super.key});

  @override
  State<CreateRepositoryPage> createState() => _CreateRepositoryPageState();
}

class _CreateRepositoryPageState extends State<CreateRepositoryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return YaruDetailPage(
      appBar: YaruWindowTitleBar(
        backgroundColor: Colors.transparent,
        leading: Center(
          child: YaruBackButton(
            onPressed: () {
              context.read<CreateRepositoryCubit>().clear();
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Text("Add a new repository"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              PathTextFieldWidget(),
              PasswordTextFieldWidget(),
              AliasTextFieldWidget(),
              BlocBuilder<CreateRepositoryCubit, CreateRepositoryModel>(
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
                        context.read<RepositoryListCubit>().addRepository(
                              RepositoryModel(
                                path: state.path!,
                                passwordFile: state.passwordFile!,
                                alias: state.isAliasExisting()
                                    ? state.alias!
                                    : null,
                              ),
                            );
                        context.read<CreateRepositoryCubit>().clear();
                        return Navigator.of(context).pop();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text("Add"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

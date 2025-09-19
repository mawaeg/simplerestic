import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../../backend/restic_command/restic_command_cat_config.dart';
import '../../../backend/restic_command_executor.dart';
import '../../../backend/restic_types/restic_return_type.dart';
import '../../cubits/create_repository_cubit.dart';
import '../../models/create_repository_model.dart';
import 'alert_results/repository_not_existing_widget.dart';
import 'alert_results/wrong_password_provided_widget.dart';

class CheckRepositoryExistingAlertDialog extends StatelessWidget {
  const CheckRepositoryExistingAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Adding repository..."),
        isClosable: false,
      ),
      content: SizedBox(
        height: 100,
        child: BlocBuilder<CreateRepositoryCubit, CreateRepositoryModel>(
            builder: (context, state) {
          return FutureBuilder(
            future: ResticCommandExecutor().executeCommandAsync(
              ResticCommandCatConfig(
                repository: state.path!,
                passwordFile: state.passwordFile!,
              ),
            ),
            builder: (context, state) {
              if (!state.hasData) {
                return Center(
                  child: YaruCircularProgressIndicator(),
                );
              } else {
                ResticReturnType returnType =
                    state.data!.last as ResticReturnType;
                if (returnType.exitCode == 0) {
                  context.read<CreateRepositoryCubit>().setIsSuccessful(true);
                  Navigator.maybePop(context);
                  return Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text("Repository exists."),
                  );
                } else if (returnType.exitCode == 10) {
                  return RepositoryNotExistingWidget();
                } else if (returnType.exitCode == 12) {
                  return WrongPasswordProvidedWidget();
                } else {
                  return Text("Some error occurred. Repository was not added.");
                }
              }
            },
          );
        }),
      ),
    );
  }
}

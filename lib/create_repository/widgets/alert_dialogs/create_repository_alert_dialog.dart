import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../../backend/restic_command/restic_command_init.dart';
import '../../../backend/restic_command_executor.dart';
import '../../../backend/restic_types/restic_return_type.dart';
import '../../cubits/create_repository_cubit.dart';
import '../../models/create_repository_model.dart';

class CreateRepositoryAlertDialog extends StatelessWidget {
  const CreateRepositoryAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Creating repository..."),
        isClosable: true,
      ),
      content: SizedBox(
        height: 100,
        child: BlocBuilder<CreateRepositoryCubit, CreateRepositoryModel>(
            builder: (context, state) {
          return FutureBuilder(
            future: ResticCommandExecutor(
              ResticCommandInit(
                repository: state.path!,
                passwordFile: state.passwordFile!,
              ),
            ).executeCommandAsync(),
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
                  return Text("Repository created successfully.");
                } else {
                  return Column(
                    children: [
                      Text("Error while creating repository!."),
                    ],
                  );
                }
              }
            },
          );
        }),
      ),
    );
  }
}

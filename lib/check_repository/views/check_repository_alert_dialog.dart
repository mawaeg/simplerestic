import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/restic_command_check.dart';
import '../../backend/restic_command_executor.dart';
import '../../backend/restic_types/primitives/check/restic_check_summary_type.dart';
import '../../backend/restic_types/restic_return_type.dart';
import '../../common/models/repository_model.dart';
import '../widgets/check_repository_summary_widget.dart';

class CheckRepositoryAlertDialog extends StatelessWidget {
  final RepositoryModel repository;

  const CheckRepositoryAlertDialog({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    ResticCheckSummaryType? summary;
    ResticReturnType? returnType;
    return AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: YaruDialogTitleBar(
          title: Text("Check ${repository.alias ?? repository.path}"),
          isClosable: true,
        ),
        content: SizedBox(
          height: 100,
          //width: 500,
          child: StreamBuilder(
              stream: ResticCommandExecutor().executeCommand(
                ResticCommandCheck(
                  repository: repository.path,
                  passwordFile: repository.passwordFile,
                ),
              ),
              builder: (context, snapshot) {
                // Save summary and error
                if (snapshot.data is ResticCheckSummaryType) {
                  summary = snapshot.data as ResticCheckSummaryType;
                }
                if (snapshot.data is ResticReturnType) {
                  returnType = snapshot.data as ResticReturnType;
                }

                if (returnType?.exitCode == 0 &&
                    summary != null &&
                    snapshot.connectionState == ConnectionState.done) {
                  return CheckRepositorySummaryWidget(
                    summary: summary!,
                  );
                }
                // If no data is yet provided and stream is not done show loading -> check command only returns summary
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: YaruCircularProgressIndicator(),
                  );
                }
                if (returnType?.exitCode != 0) {
                  return Center(
                    child: Text(
                      "Restic command failed with exit code ${returnType!.exitCode}.",
                    ),
                  );
                }

                return Center(child: Text("Something unexpected went wrong"));
              }),
        ));
  }
}

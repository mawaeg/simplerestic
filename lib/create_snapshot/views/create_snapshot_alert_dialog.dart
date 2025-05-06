import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/models/repository_model.dart';
import '../../create_repository/widgets/base_text_field_widget.dart';
import '../widgets/create_snapshot_button_widget.dart';
import '../widgets/snapshot_path_text_field_widget.dart';

class CreateSnapshotAlertDialog extends StatelessWidget {
  final RepositoryModel repository;

  CreateSnapshotAlertDialog({
    super.key,
    required this.repository,
  });

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _pathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Create a new snapshot"),
        isClosable: true,
      ),
      content: SizedBox(
        height: 211,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10.0,
            children: [
              SnapshotPathTextFieldWidget(pathController: _pathController),
              BaseTextFieldWidget(
                description: "Assign an alias to the snapshot:",
                hintText: "Alias",
                controller: _aliasController,
              ),
              CreateSnapshotButtonWidget(
                formKey: _formKey,
                repository: repository,
                pathController: _pathController,
                aliasController: _aliasController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

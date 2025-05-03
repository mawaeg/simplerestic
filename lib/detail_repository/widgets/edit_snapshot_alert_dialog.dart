import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/snapshot_cubit.dart';
import '../../common/models/repository_model.dart';
import '../../common/models/snapshot_model.dart';
import '../../create_repository/widgets/base_text_field_widget.dart';

class EditSnapshotAlertDialog extends StatelessWidget {
  final RepositoryModel repository;
  final SnapshotModel? snapshot;
  final String path;
  late final TextEditingController _controller;

  EditSnapshotAlertDialog({
    super.key,
    required this.repository,
    this.snapshot,
    required this.path,
  }) {
    _controller = TextEditingController(text: snapshot?.alias);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        title: Text("Edit snapshot"),
        isClosable: true,
      ),
      content: SizedBox(
        height: 111,
        child: Column(
          children: [
            BaseTextFieldWidget(
              description: "Assign an alias to the snapshot:",
              hintText: "Alias",
              controller: _controller,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  if (snapshot != null && _controller.text.isEmpty) {
                    context
                        .read<SnapshotCubit>()
                        .removeSnapshotByPath(repository.id!, path);
                  } else if (snapshot != null && _controller.text.isNotEmpty) {
                    context
                        .read<SnapshotCubit>()
                        .updateSnapshot(snapshot!..alias = _controller.text);
                  } else {
                    context.read<SnapshotCubit>().addSnapshot(
                          SnapshotModel(
                            repositoryId: repository.id!,
                            path: path,
                            alias: _controller.text,
                          ),
                        );
                  }
                  Navigator.maybePop(context);
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}

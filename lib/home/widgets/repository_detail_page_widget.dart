import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../common/models/repository_model.dart';
import 'buttons/check_repository_button.dart';
import 'buttons/create_new_snapshot_button_widget.dart';
import '../../detail_repository/views/snapshot_list_view.dart';
import '../../common/widgets/mount_button_widget.dart';

class RepositoryDetailPageWidget extends StatelessWidget {
  final RepositoryModel repository;

  const RepositoryDetailPageWidget({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return YaruDetailPage(
      appBar: YaruWindowTitleBar(
        title: Text(repository.alias ?? repository.path),
        backgroundColor: Colors.transparent,
        leading: Center(
          child: CreateNewSnapshotButtonWidget(
            repository: repository,
          ),
        ),
        actions: [
          MountButtonWidget(
            repository: repository.path,
            passwordFile: repository.passwordFile,
          ),
          CheckRepositoryButton(
            repository: repository,
          ),
        ],
      ),
      body: SnapshotListView(repository: repository),
    );
  }
}

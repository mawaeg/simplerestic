import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_cubit.dart';
import '../../common/models/repository_model.dart';
import '../../common/widgets/simple_restic_yaru_option_button.dart';
import '../../common/widgets/tap_to_copy_text.dart';
import '../../create_repository/view/create_repository_alert_dialog.dart';

class RepositoryListYaruMasterTile extends StatelessWidget {
  final RepositoryModel repository;

  const RepositoryListYaruMasterTile({
    super.key,
    required this.repository,
  });
  @override
  Widget build(BuildContext context) {
    return YaruMasterTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TapToCopyText(
              text: repository.alias ?? repository.path,
              textToCopy: repository.path,
              description: "path",
            ),
          ),
        ],
      ),
      subtitle: repository.alias != null ? Text(repository.path) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SimpleResticYaruOptionButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CreateRepositoryAlertDialog(
                    create: false,
                    repository: repository,
                  );
                },
              );
            },
            child: const Icon(YaruIcons.settings),
          ),
          SimpleResticYaruOptionButton(
            onPressed: () {
              context.read<RepositoryCubit>().removeRepository(repository);
            },
            child: const Icon(YaruIcons.trash),
          ),
        ],
      ),
    );
  }
}

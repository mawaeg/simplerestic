import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplerestic/home/widgets/repository_list_yaru_master_tile.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_list_cubit.dart';
import '../../common/models/repository_list_model.dart';

class RepositoryListView extends StatelessWidget {
  const RepositoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryListCubit, RepositoryListModel>(
      builder: (context, state) {
        return YaruMasterDetailPage(
          paneLayoutDelegate: YaruFixedPaneDelegate(paneSize: 400),
          length: state.getRepositories().length,
          tileBuilder: (context, index, selected, availableWidth) {
            return RepositoryListYaruMasterTile(
              path: state.getRepositories()[index].path,
              alias: state.getRepositories()[index].alias,
            );
          },
          pageBuilder: (context, index) {
            return Center(
              child: Text(
                state.getRepositories()[index].alias ??
                    state.getRepositories()[index].path,
              ),
            );
          },
        );
      },
    );
  }
}

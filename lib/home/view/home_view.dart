import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_list_cubit.dart';
import '../../common/models/repository_list_model.dart';
import '../widgets/create_repository_widget.dart';
import '../widgets/options_widget.dart';
import '../widgets/repository_detail_page_widget.dart';
import '../widgets/repository_list_yaru_master_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryListCubit, RepositoryListModel>(
      builder: (context, state) {
        return Scaffold(
          body: YaruMasterDetailPage(
            appBar: YaruWindowTitleBar(
              title: Text("SimpleRestic"),
              backgroundColor: Colors.transparent,
              leading: Center(child: CreateRepositoryWidget()),
              actions: [OptionsWidget()],
            ),
            paneLayoutDelegate: YaruFixedPaneDelegate(paneSize: 400),
            length: state.getRepositories().length,
            tileBuilder: (context, index, selected, availableWidth) {
              return RepositoryListYaruMasterTile(
                path: state.getRepositories()[index].path,
                alias: state.getRepositories()[index].alias,
              );
            },
            pageBuilder: (context, index) {
              return RepositoryDetailPageWidget(
                path: state.getRepositories()[index].path,
                alias: state.getRepositories()[index].alias,
              );
            },
          ),
        );
      },
    );
  }
}

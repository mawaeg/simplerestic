import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_cubit.dart';
import '../../common/models/repository_model.dart';
import '../../create_repository/view/create_repository_alert_dialog.dart';
import '../widgets/create_repository_widget.dart';
import '../widgets/options_widget.dart';
import '../widgets/repository_detail_page_widget.dart';
import '../widgets/repository_list_yaru_master_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryCubit, List<RepositoryModel>>(
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
            length: state.length,
            tileBuilder: (context, index, selected, availableWidth) {
              return RepositoryListYaruMasterTile(repository: state[index]);
            },
            pageBuilder: (context, index) {
              return RepositoryDetailPageWidget(
                repository: state[index],
              );
            },
            emptyBuilder: (context) {
              return Scaffold(
                appBar: YaruWindowTitleBar(
                  title: Text("SimpleRestic"),
                  backgroundColor: Colors.transparent,
                  leading: Center(child: CreateRepositoryWidget()),
                  actions: [OptionsWidget()],
                ),
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => CreateRepositoryAlertDialog()),
                      );
                    },
                    child: Text("Create a repository."),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

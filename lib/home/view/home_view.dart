import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_cubit.dart';
import '../../common/models/repository_model.dart';
import '../../create_repository/view/create_repository_alert_dialog.dart';
import '../widgets/buttons/create_repository_button_widget.dart';
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
              leading: Center(child: CreateRepositoryButtonWidget()),
              actions: [OptionsWidget()],
            ),
            paneLayoutDelegate: YaruFixedPaneDelegate(paneSize: 450),
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
                  leading: Center(child: CreateRepositoryButtonWidget()),
                  actions: [OptionsWidget()],
                ),
                body: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return CreateRepositoryAlertDialog();
                        },
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

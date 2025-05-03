import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_list_cubit.dart';
import '../../common/models/repository_list_model.dart';
import '../../common/models/repository_model.dart';
import '../utils/create_snapshot_list_model.dart';
import '../widgets/snapshot_list_tile_widget.dart';

class SnapshotListView extends StatelessWidget {
  final String path;
  final String? alias;
  final String passwordFile;

  const SnapshotListView({
    super.key,
    required this.path,
    required this.alias,
    required this.passwordFile,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: createSnapshotListModel(path, passwordFile),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: YaruCircularProgressIndicator(),
          );
        }
        return BlocBuilder<RepositoryListCubit, RepositoryListModel>(
          builder: (context, state) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  String snapshotPath =
                      snapshot.data!.snapshots.keys.toList()[index];
                  RepositoryModel model = state.getRepositoryByPath(path);
                  String? alias = model.getSnapshotByPath(snapshotPath);
                  return SnapshotListTileWidget(
                    alias: alias,
                    snapshotPath: snapshotPath,
                    model: model,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: snapshot.data!.length);
          },
        );
      },
    );
  }
}

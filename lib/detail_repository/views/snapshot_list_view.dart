import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/snapshot_cubit.dart';
import '../../common/cubits/snapshot_rebuild_cubit.dart';
import '../../common/models/repository_model.dart';
import '../../common/models/snapshot_model.dart';
import '../utils/create_snapshot_list_model.dart';
import '../widgets/snapshot_list_tile_widget.dart';

class SnapshotListView extends StatelessWidget {
  final RepositoryModel repository;

  const SnapshotListView({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SnapshotRebuildCubit, bool>(
      builder: (context, state) {
        return FutureBuilder(
          future:
              createSnapshotListModel(repository.path, repository.passwordFile),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: YaruCircularProgressIndicator(),
              );
            }
            return BlocBuilder<SnapshotCubit, List<SnapshotModel>>(
              builder: (context, state) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      List<String> path =
                          snapshot.data!.snapshots.keys.toList()[index].paths!;
                      SnapshotModel? snapshotModel = state
                          .where(
                            (element) =>
                                SnapshotModel.arePathListsIdentical(
                                    element.pathList, path) &&
                                element.repositoryId == repository.id!,
                          )
                          .firstOrNull;
                      return SnapshotListTileWidget(
                        repository: repository,
                        path: path,
                        snapshot: snapshotModel,
                        snapshots: snapshot.data!.snapshots[
                            snapshot.data!.snapshots.keys.toList()[index]]!,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snapshot.data!.snapshots.length);
              },
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_list_cubit.dart';
import '../../common/models/repository_list_model.dart';

class RepositoryListView extends StatelessWidget {
  const RepositoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryListCubit, RepositoryListModel>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.all(kYaruPagePadding),
          itemCount: state.getRepositories().length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 700,
                child: YaruTile(
                  title: Text(
                    state.getRepositories()[index].alias ??
                        state.getRepositories()[index].path,
                  ),
                  subtitle: state.getRepositories()[index].alias != null
                      ? Text(state.getRepositories()[index].path)
                      : null,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

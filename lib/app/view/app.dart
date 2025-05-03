import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaru/yaru.dart';

import '../../common/cubits/repository_cubit.dart';
import '../../common/cubits/snapshot_cubit.dart';
import '../../create_repository/cubits/create_repository_cubit.dart';
import '../../home/view/home_view.dart';

class SimpleResticApp extends StatelessWidget {
  const SimpleResticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => RepositoryCubit()..init()),
            BlocProvider(create: (_) => SnapshotCubit()..init()),
            BlocProvider(create: (_) => CreateRepositoryCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: yaru.theme,
            darkTheme: yaru.darkTheme,
            home: HomeView(),
          ),
        );
      },
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yaru/yaru.dart';

import 'app/view/app.dart';

Future<void> main() async {
  await YaruWindowTitleBar.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            "${(await getApplicationDocumentsDirectory()).path}/simplerestic"),
  );

  runApp(const SimpleResticApp());
}

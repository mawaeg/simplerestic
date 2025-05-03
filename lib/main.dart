import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import 'app/view/app.dart';

Future<void> main() async {
  await YaruWindowTitleBar.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SimpleResticApp());
}

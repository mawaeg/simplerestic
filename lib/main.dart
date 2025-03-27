import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  await YaruWindowTitleBar.ensureInitialized();

  runApp(const SimpleRestic());
}

class SimpleRestic extends StatelessWidget {
  const SimpleRestic({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        builder: (context, child) => Scaffold(
          appBar: const YaruWindowTitleBar(title: Text("SimpleRestic")),
          body: child,
        ),
        home: const Center(child: Text("Hello World!")),
      ),
    );
  }
}

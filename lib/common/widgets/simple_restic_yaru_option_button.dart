import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class SimpleResticYaruOptionButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const SimpleResticYaruOptionButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return YaruOptionButton(
      style: ButtonStyle(
        side: WidgetStateProperty.all(BorderSide.none),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

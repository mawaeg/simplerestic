import 'package:flutter/material.dart';

class WrongPasswordProvidedWidget extends StatelessWidget {
  const WrongPasswordProvidedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Wrong password provided! Please enter a valid password file.",
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          child: Text("Return"),
        ),
      ],
    );
  }
}

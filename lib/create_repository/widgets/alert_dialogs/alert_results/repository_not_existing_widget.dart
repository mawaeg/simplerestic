import 'package:flutter/material.dart';

import '../create_repository_alert_dialog.dart';

class RepositoryNotExistingWidget extends StatelessWidget {
  const RepositoryNotExistingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Repository does not exist!"),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (builder) {
                  return CreateRepositoryAlertDialog();
                });
            if (context.mounted) {
              Navigator.maybePop(context);
            }
          },
          child: Text("Create repository"),
        ),
      ],
    );
  }
}

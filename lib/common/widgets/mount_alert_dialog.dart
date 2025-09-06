import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import '../../backend/restic_command/base/restic_command.dart';
import '../../backend/restic_command/restic_command_mount.dart';
import '../../backend/restic_command_executor.dart';
import '../utils/folder_utils.dart';
import 'open_folder_button_widget.dart';

const mountPointPath = "simplerestic/mountpoint";

class MountAlertDialog extends StatelessWidget {
  final String repository;
  final String passwordFile;
  final dynamic path;

  const MountAlertDialog({
    super.key,
    required this.repository,
    required this.passwordFile,
    this.path,
  });

  Future<Process> mountProcess() async {
    String absMountPointPath =
        await getMountPointPath(mountPointPath, create: true);
    ResticCommand command = ResticCommandMount(
      repository: repository,
      passwordFile: passwordFile,
      mountPoint: absMountPointPath,
      path: path,
    );
    final process = await ResticCommandExecutor.startCommandProcess(command);
    return process;
  }

  Future<void> killProcessAndMaybePop(
      BuildContext context, Process process) async {
    process.kill();
    await Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mountProcess(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: YaruDialogTitleBar(
              title: Text("Mount"),
              isClosable: true,
              onClose: (_) async {
                killProcessAndMaybePop(context, snapshot.data!);
              },
            ),
            content: SizedBox(
              height: 100,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OpenFolderButtonWidget(
                    path: mountPointPath,
                    asyncPathModifierHook: getMountPointPath,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      killProcessAndMaybePop(context, snapshot.data!);
                    },
                    child: Text(
                      "Unmount",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

import '../../backend/restic_command/base/restic_command.dart';

sealed class BackupQueueEvent {}

final class AddCommand extends BackupQueueEvent {
  final ResticCommand command;

  AddCommand(this.command);
}

final class RemoveFinishedCommand extends BackupQueueEvent {
  final ResticCommand command;

  RemoveFinishedCommand(this.command);
}

final class ProcessNext extends BackupQueueEvent {}

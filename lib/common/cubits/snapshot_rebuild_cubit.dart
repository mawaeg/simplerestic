import 'package:flutter_bloc/flutter_bloc.dart';

// Used to retrigger the snapshot list view after creating a new snapshot
class SnapshotRebuildCubit extends Cubit<bool> {
  SnapshotRebuildCubit() : super(false);

  void toggle() {
    emit(!state);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class PruneDataButtonCubit extends Cubit<bool> {
  PruneDataButtonCubit() : super(true);

  void set(bool value) {
    emit(value);
  }
}

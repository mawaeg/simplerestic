import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../common/models/snapshot_interval_options_enum.dart';
import '../../common/widgets/interval_select_text_field.dart';
import '../cubits/create_repository_cubit.dart';
import '../utils/duration_to_interval.dart';

class RepositoryIntervalSelectTextFieldWidget extends StatefulWidget {
  final Duration? initialInterval;
  const RepositoryIntervalSelectTextFieldWidget({
    super.key,
    this.initialInterval,
  });

  @override
  State<RepositoryIntervalSelectTextFieldWidget> createState() =>
      _RepositoryIntervalSelectTextFieldWidgetState();
}

class _RepositoryIntervalSelectTextFieldWidgetState
    extends State<RepositoryIntervalSelectTextFieldWidget> {
  final TextEditingController _intervalController =
      TextEditingController(text: "7");
  SnapshotIntervalOptionsEnum _intervalOption =
      SnapshotIntervalOptionsEnum.days;
  @override
  void initState() {
    super.initState();
    if (widget.initialInterval != null) {
      Tuple2<String, SnapshotIntervalOptionsEnum> resolvedInterval =
          durationToInterval(widget.initialInterval!);
      _intervalController.text = resolvedInterval.item1;
      _intervalOption = resolvedInterval.item2;
    }

    context.read<CreateRepositoryCubit>().setInterval(
        int.tryParse(_intervalController.text) ?? 0, _intervalOption);
  }

  @override
  Widget build(BuildContext context) {
    void setInterval(String? interval) {
      if (context.mounted) {
        context
            .read<CreateRepositoryCubit>()
            .setInterval(int.tryParse(interval ?? "0") ?? 0, _intervalOption);
      }
    }

    void setIntervalOption(
        String? interval, SnapshotIntervalOptionsEnum intervalOption) {
      _intervalOption = intervalOption;
      setInterval(interval);
    }

    return IntervalSelectTextField(
      controller: _intervalController,
      intervalOption: _intervalOption,
      onChanged: setInterval,
      onIntervalOptionChanged: setIntervalOption,
    );
  }
}

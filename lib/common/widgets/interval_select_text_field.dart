import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaru/yaru.dart';

import '../../create_repository/widgets/base_text_field_widget.dart';
import '../models/snapshot_interval_options_enum.dart';

class IntervalSelectTextField extends StatefulWidget {
  final TextEditingController controller;
  final SnapshotIntervalOptionsEnum intervalOption;
  final void Function(String?)? onChanged;
  final void Function(String?, SnapshotIntervalOptionsEnum)?
      onIntervalOptionChanged;
  const IntervalSelectTextField({
    super.key,
    required this.controller,
    required this.intervalOption,
    this.onChanged,
    this.onIntervalOptionChanged,
  });

  @override
  State<IntervalSelectTextField> createState() =>
      _IntervalSelectTextFieldState();
}

class _IntervalSelectTextFieldState extends State<IntervalSelectTextField> {
  late SnapshotIntervalOptionsEnum intervalOption;

  @override
  void initState() {
    super.initState();

    intervalOption = widget.intervalOption;
  }

  @override
  Widget build(BuildContext context) {
    return BaseTextFieldWidget(
      description: "The interval snapshots should be created",
      hintText: "interval",
      controller: widget.controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      suffixIcon: YaruPopupMenuButton<SnapshotIntervalOptionsEnum>(
        initialValue: intervalOption,
        onSelected: (value) {
          setState(() {
            intervalOption = value;
          });
          if (widget.onIntervalOptionChanged != null) {
            widget.onIntervalOptionChanged!(widget.controller.text, value);
          }
        },
        // ToDo Remove hover animation?
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kYaruButtonRadius),
            ),
          ),
        ),
        padding: EdgeInsets.only(right: 5),
        child: Text(intervalOption.name),
        itemBuilder: (context) {
          return [
            for (final value in SnapshotIntervalOptionsEnum.values)
              PopupMenuItem(
                value: value,
                child: Text(value.name),
              )
          ];
        },
      ),
      onChanged: widget.onChanged,
    );
  }
}

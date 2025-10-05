import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> onTapCopyAction(
  BuildContext context,
  String textToCopy,
  String description,
) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Copied $description to clipboard.",
        textWidthBasis: TextWidthBasis.longestLine,
      ),
      duration: const Duration(seconds: 2),
    ),
  );
  await Clipboard.setData(ClipboardData(text: textToCopy));
}

class TapToCopyText extends StatelessWidget {
  final String text;
  final String textToCopy;
  final String description;
  final String? tooltipMessage;

  const TapToCopyText({
    super.key,
    required this.text,
    required this.textToCopy,
    required this.description,
    this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onTapCopyAction(context, textToCopy, description);
      },
      child: Tooltip(
        message: tooltipMessage ?? "",
        child: Text(
          text,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

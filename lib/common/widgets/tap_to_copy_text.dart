import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      },
      child: Tooltip(
        message: tooltipMessage ?? "",
        child: Text(
          text,
        ),
      ),
    );
  }
}

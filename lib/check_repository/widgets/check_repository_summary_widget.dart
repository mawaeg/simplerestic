import 'package:flutter/material.dart';

import '../../backend/restic_types/primitives/check/restic_check_summary_type.dart';

class CheckRepositorySummaryWidget extends StatelessWidget {
  final ResticCheckSummaryType summary;

  const CheckRepositorySummaryWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Errors detected in repository: ${summary.numErrors}"),
        Text(
          "Broken packs: ${summary.brokenPacks != null ? summary.brokenPacks!.length : 0}",
        ),
        Text(
          "Suggestion to repair index: ${summary.suggestRepairIndex ? 'yes' : 'no'}",
        ),
        Text(
          "Suggestion to run prune: ${summary.suggestPrune ? 'yes' : 'no'}",
        ),
      ],
    );
  }
}

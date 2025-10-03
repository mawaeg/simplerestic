import '../../base/restic_json_type.dart';

class ResticCheckSummaryType extends ResticJsonType {
  final int numErrors;
  final List<String>? brokenPacks;
  final bool suggestRepairIndex;
  final bool suggestPrune;

  ResticCheckSummaryType(
    this.numErrors,
    this.brokenPacks,
    this.suggestRepairIndex,
    this.suggestPrune,
  );

  factory ResticCheckSummaryType.fromJson(dynamic json) =>
      ResticCheckSummaryType(
        json["num_errors"],
        json["broken_packs"],
        json["suggest_repair_index"],
        json["suggest_prune"],
      );

  @override
  List<Object?> get props => [
        numErrors,
        brokenPacks,
        suggestRepairIndex,
        suggestPrune,
      ];
}

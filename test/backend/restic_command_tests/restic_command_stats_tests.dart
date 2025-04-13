import 'package:flutter_test/flutter_test.dart';
import 'package:simplerestic/backend/restic_command/restic_command_stats.dart';
import 'package:simplerestic/backend/restic_types/primitives/stats/restic_stats_type.dart';

void main() {
  ResticCommandStats resticCommand =
      ResticCommandStats(repository: "testRepo", passwordFile: "testPassword");
  group(
      "Check that ResticCommandStats builds commands as expected and correctly parses Json",
      () {
    test("Ensure ResticCommandStats correctly builds a command.", () {
      expect(resticCommand.build(), [
        "stats",
        "--json",
        "--repo",
        "testRepo",
        "--password-file",
        "testPassword",
      ]);
    });
    test("Ensure ResticCommandStats correctly parses Json", () {
      Map<String, dynamic> json = {
        "total_size": 1,
        "total_file_count": 2,
        "total_blob_count": 3,
        "snapshots_count": 4,
        "total_uncompressed_size": 5,
        "compression_ration": 6.0,
        "compression_progress": 7.0,
        "compression_space_saving": 8.0
      };
      expect(
        resticCommand.parseJson(json),
        ResticStatsType(1, 2, 3, 4, 5, 6.0, 7.0, 8.0),
      );

      Map<String, dynamic> onlyRequiredJson = {
        "total_size": 1,
        "snapshots_count": 4,
        "total_uncompressed_size": 5,
      };
      expect(
        resticCommand.parseJson(onlyRequiredJson),
        ResticStatsType(1, null, null, 4, 5, null, null, null),
      );
    });
  });
}

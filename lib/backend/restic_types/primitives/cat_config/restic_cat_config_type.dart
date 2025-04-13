import '../../base/restic_json_type.dart';

class ResticCatConfigType extends ResticJsonType {
  final int version;
  final String id;
  final String chunkerPolynomial;

  ResticCatConfigType(this.version, this.id, this.chunkerPolynomial);

  factory ResticCatConfigType.fromJson(Map<String, dynamic> json) {
    return ResticCatConfigType(
      json["version"],
      json["id"],
      json["chunker_polynomial"],
    );
  }

  @override
  List<Object?> get props => [version, id, chunkerPolynomial];
}

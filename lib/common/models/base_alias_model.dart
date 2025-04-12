import 'package:equatable/equatable.dart';

class BaseAliasModel extends Equatable {
  final String path;
  final String? alias;

  const BaseAliasModel({required this.path, this.alias});

  factory BaseAliasModel.fromJson(Map<String, dynamic> json) {
    return BaseAliasModel(
      path: json["path"],
      alias: json["alias"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "path": path,
      "alias": alias,
    };
  }

  @override
  List<Object?> get props => [path, alias];
}

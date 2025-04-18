// ignore_for_file: unused_import

import 'package:json_annotation/json_annotation.dart';
part 'config_model.g.dart';
@JsonSerializable()
class ConfigModel {
  @JsonKey(name: 'geminiAPIkey')
  final String geminiAPIkey;

  ConfigModel({required this.geminiAPIkey});

  factory ConfigModel.fromJson(Map<String, dynamic>json) => _$ConfigModelFromJson(json);
}
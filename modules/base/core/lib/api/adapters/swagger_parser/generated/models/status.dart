// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status {
  const Status({
    required this.status,
  });
  
  factory Status.fromJson(Map<String, Object?> json) => _$StatusFromJson(json);
  
  final String status;

  Map<String, Object?> toJson() => _$StatusToJson(this);
}

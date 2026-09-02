// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'decline.g.dart';

@JsonSerializable()
class Decline {
  const Decline({
    this.status,
  });
  
  factory Decline.fromJson(Map<String, Object?> json) => _$DeclineFromJson(json);
  
  final String? status;

  Map<String, Object?> toJson() => _$DeclineToJson(this);
}

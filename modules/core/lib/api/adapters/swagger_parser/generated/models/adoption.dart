// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'adoption.g.dart';

/// Adoption serializer
@JsonSerializable()
class Adoption {
  const Adoption({
    this.startDate,
    this.endDate,
    this.adopter,
  });
  
  factory Adoption.fromJson(Map<String, Object?> json) => _$AdoptionFromJson(json);
  
  @JsonKey(name: 'start_date')
  final DateTime? startDate;
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  final int? adopter;

  Map<String, Object?> toJson() => _$AdoptionToJson(this);
}

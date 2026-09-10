// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'patched_adoption.g.dart';

/// Adoption serializer
@JsonSerializable()
class PatchedAdoption {
  const PatchedAdoption({
    this.startDate,
    this.endDate,
    this.adopter,
  });
  
  factory PatchedAdoption.fromJson(Map<String, Object?> json) => _$PatchedAdoptionFromJson(json);
  
  @JsonKey(name: 'start_date')
  final DateTime? startDate;
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  final int? adopter;

  Map<String, Object?> toJson() => _$PatchedAdoptionToJson(this);
}

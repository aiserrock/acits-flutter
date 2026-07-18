// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'patched_overstay.g.dart';

/// Overstay serializer.
@JsonSerializable()
class PatchedOverstay {
  const PatchedOverstay({
    this.startDate,
    this.endDate,
    this.animalSitter,
  });
  
  factory PatchedOverstay.fromJson(Map<String, Object?> json) => _$PatchedOverstayFromJson(json);
  
  @JsonKey(name: 'start_date')
  final DateTime? startDate;
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  @JsonKey(name: 'animal_sitter')
  final int? animalSitter;

  Map<String, Object?> toJson() => _$PatchedOverstayToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'overstay.g.dart';

/// Overstay serializer.
@JsonSerializable()
class Overstay {
  const Overstay({
    this.startDate,
    this.endDate,
    this.animalSitter,
  });
  
  factory Overstay.fromJson(Map<String, Object?> json) => _$OverstayFromJson(json);
  
  @JsonKey(name: 'start_date')
  final DateTime? startDate;
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  @JsonKey(name: 'animal_sitter')
  final int? animalSitter;

  Map<String, Object?> toJson() => _$OverstayToJson(this);
}

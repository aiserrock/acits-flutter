// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_overstay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedOverstay _$PatchedOverstayFromJson(Map<String, dynamic> json) =>
    PatchedOverstay(
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      animalSitter: (json['animal_sitter'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PatchedOverstayToJson(PatchedOverstay instance) =>
    <String, dynamic>{
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'animal_sitter': instance.animalSitter,
    };

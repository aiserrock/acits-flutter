// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adoption _$AdoptionFromJson(Map<String, dynamic> json) => Adoption(
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  adopter: (json['adopter'] as num?)?.toInt(),
);

Map<String, dynamic> _$AdoptionToJson(Adoption instance) => <String, dynamic>{
  'start_date': instance.startDate?.toIso8601String(),
  'end_date': instance.endDate?.toIso8601String(),
  'adopter': instance.adopter,
};

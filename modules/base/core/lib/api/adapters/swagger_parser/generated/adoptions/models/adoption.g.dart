// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adoption _$AdoptionFromJson(Map<String, dynamic> json) => Adoption(
  startDate: Adoption._read_startDate(json['start_date']),
  endDate: Adoption._read_endDate(json['end_date']),
  adopter: Adoption._read_adopter(json['adopter']),
  additionalProperties: Adoption._extras(json, 'additionalProperties') == null
      ? const {}
      : Adoption._readExtras(Adoption._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$AdoptionToJson(Adoption instance) => <String, dynamic>{
  'start_date': ?Adoption._write_startDate(instance.startDate),
  'end_date': ?Adoption._write_endDate(instance.endDate),
  'adopter': ?Adoption._write_adopter(instance.adopter),
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overstay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Overstay _$OverstayFromJson(Map<String, dynamic> json) => Overstay(
  startDate: Overstay._read_startDate(json['start_date']),
  endDate: Overstay._read_endDate(json['end_date']),
  animalSitter: Overstay._read_animalSitter(json['animal_sitter']),
  additionalProperties: Overstay._extras(json, 'additionalProperties') == null
      ? const {}
      : Overstay._readExtras(Overstay._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$OverstayToJson(Overstay instance) => <String, dynamic>{
  'start_date': ?Overstay._write_startDate(instance.startDate),
  'end_date': ?Overstay._write_endDate(instance.endDate),
  'animal_sitter': ?Overstay._write_animalSitter(instance.animalSitter),
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_overstay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedOverstay _$PatchedOverstayFromJson(Map<String, dynamic> json) =>
    PatchedOverstay(
      startDate: PatchedOverstay._read_startDate(json['start_date']),
      endDate: PatchedOverstay._read_endDate(json['end_date']),
      animalSitter: PatchedOverstay._read_animalSitter(json['animal_sitter']),
      additionalProperties:
          PatchedOverstay._extras(json, 'additionalProperties') == null
          ? const {}
          : PatchedOverstay._readExtras(
              PatchedOverstay._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PatchedOverstayToJson(
  PatchedOverstay instance,
) => <String, dynamic>{
  'start_date': ?PatchedOverstay._write_startDate(instance.startDate),
  'end_date': ?PatchedOverstay._write_endDate(instance.endDate),
  'animal_sitter': ?PatchedOverstay._write_animalSitter(instance.animalSitter),
};

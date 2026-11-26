// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_adoption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedAdoption _$PatchedAdoptionFromJson(Map<String, dynamic> json) =>
    PatchedAdoption(
      startDate: PatchedAdoption._read_startDate(json['start_date']),
      endDate: PatchedAdoption._read_endDate(json['end_date']),
      adopter: PatchedAdoption._read_adopter(json['adopter']),
      additionalProperties:
          PatchedAdoption._extras(json, 'additionalProperties') == null
          ? const {}
          : PatchedAdoption._readExtras(
              PatchedAdoption._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PatchedAdoptionToJson(PatchedAdoption instance) =>
    <String, dynamic>{
      'start_date': ?PatchedAdoption._write_startDate(instance.startDate),
      'end_date': ?PatchedAdoption._write_endDate(instance.endDate),
      'adopter': ?PatchedAdoption._write_adopter(instance.adopter),
    };

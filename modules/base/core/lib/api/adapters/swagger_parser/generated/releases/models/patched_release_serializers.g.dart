// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_release_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedReleaseSerializers _$PatchedReleaseSerializersFromJson(
  Map<String, dynamic> json,
) => PatchedReleaseSerializers(
  id: PatchedReleaseSerializers._read_id(json['id']),
  place: json['place'] as String?,
  date: PatchedReleaseSerializers._read_date(json['date']),
  veterinarianName: json['veterinarian_name'] as String?,
  veterinarianSurname: json['veterinarian_surname'] as String?,
  veterinarianPatronymic: json['veterinarian_patronymic'] as String?,
  createdAt: PatchedReleaseSerializers._read_createdAt(json['created_at']),
  updatedAt: PatchedReleaseSerializers._read_updatedAt(json['updated_at']),
  additionalProperties:
      PatchedReleaseSerializers._extras(json, 'additionalProperties') == null
      ? const {}
      : PatchedReleaseSerializers._readExtras(
          PatchedReleaseSerializers._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PatchedReleaseSerializersToJson(
  PatchedReleaseSerializers instance,
) => <String, dynamic>{
  'id': ?PatchedReleaseSerializers._write_id(instance.id),
  'place': ?instance.place,
  'date': ?PatchedReleaseSerializers._write_date(instance.date),
  'veterinarian_name': ?instance.veterinarianName,
  'veterinarian_surname': ?instance.veterinarianSurname,
  'veterinarian_patronymic': ?instance.veterinarianPatronymic,
  'created_at': ?PatchedReleaseSerializers._write_createdAt(instance.createdAt),
  'updated_at': ?PatchedReleaseSerializers._write_updatedAt(instance.updatedAt),
};

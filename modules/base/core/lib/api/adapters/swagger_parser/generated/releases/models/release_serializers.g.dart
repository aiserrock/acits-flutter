// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseSerializers _$ReleaseSerializersFromJson(Map<String, dynamic> json) =>
    ReleaseSerializers(
      id: ReleaseSerializers._read_id(json['id']),
      place: json['place'] as String?,
      date: ReleaseSerializers._read_date(json['date']),
      veterinarianName: json['veterinarian_name'] as String?,
      veterinarianSurname: json['veterinarian_surname'] as String?,
      veterinarianPatronymic: json['veterinarian_patronymic'] as String?,
      createdAt: ReleaseSerializers._read_createdAt(json['created_at']),
      updatedAt: ReleaseSerializers._read_updatedAt(json['updated_at']),
      additionalProperties:
          ReleaseSerializers._extras(json, 'additionalProperties') == null
          ? const {}
          : ReleaseSerializers._readExtras(
              ReleaseSerializers._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$ReleaseSerializersToJson(ReleaseSerializers instance) =>
    <String, dynamic>{
      'id': ?ReleaseSerializers._write_id(instance.id),
      'place': ?instance.place,
      'date': ?ReleaseSerializers._write_date(instance.date),
      'veterinarian_name': ?instance.veterinarianName,
      'veterinarian_surname': ?instance.veterinarianSurname,
      'veterinarian_patronymic': ?instance.veterinarianPatronymic,
      'created_at': ?ReleaseSerializers._write_createdAt(instance.createdAt),
      'updated_at': ?ReleaseSerializers._write_updatedAt(instance.updatedAt),
    };

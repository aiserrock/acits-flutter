// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseSerializers _$ReleaseSerializersFromJson(Map<String, dynamic> json) =>
    ReleaseSerializers(
      id: (json['id'] as num?)?.toInt(),
      place: json['place'] as String?,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      veterinarianName: json['veterinarian_name'] as String?,
      veterinarianSurname: json['veterinarian_surname'] as String?,
      veterinarianPatronymic: json['veterinarian_patronymic'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReleaseSerializersToJson(ReleaseSerializers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'place': instance.place,
      'date': instance.date?.toIso8601String(),
      'veterinarian_name': instance.veterinarianName,
      'veterinarian_surname': instance.veterinarianSurname,
      'veterinarian_patronymic': instance.veterinarianPatronymic,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

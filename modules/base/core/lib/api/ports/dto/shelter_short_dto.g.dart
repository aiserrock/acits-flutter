// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelter_short_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShelterShortDto _$ShelterShortDtoFromJson(Map<String, dynamic> json) =>
    ShelterShortDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$ShelterShortDtoToJson(ShelterShortDto instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

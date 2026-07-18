// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelter_write_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShelterWriteDto _$ShelterWriteDtoFromJson(Map<String, dynamic> json) => ShelterWriteDto(
  name: json['name'] as String,
  country: json['country'] as String,
  city: json['city'] as String,
  region: json['region'] as String?,
);

Map<String, dynamic> _$ShelterWriteDtoToJson(ShelterWriteDto instance) => <String, dynamic>{
  'name': instance.name,
  'country': instance.country,
  'city': instance.city,
  'region': ?instance.region,
};

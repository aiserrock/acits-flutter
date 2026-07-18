// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_image_write_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalImageWriteDto _$AnimalImageWriteDtoFromJson(Map<String, dynamic> json) => AnimalImageWriteDto(
  name: json['name'] as String,
  image: json['image'] as String,
  isPrimary: json['is_primary'] as bool?,
);

Map<String, dynamic> _$AnimalImageWriteDtoToJson(AnimalImageWriteDto instance) => <String, dynamic>{
  'name': instance.name,
  'image': instance.image,
  'is_primary': instance.isPrimary,
};

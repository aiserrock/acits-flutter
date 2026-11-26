// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_image_write.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalImageWrite _$AnimalImageWriteFromJson(Map<String, dynamic> json) =>
    AnimalImageWrite(
      name: json['name'] as String,
      image: json['image'] as String,
      isPrimary: json['is_primary'] as bool?,
    );

Map<String, dynamic> _$AnimalImageWriteToJson(AnimalImageWrite instance) =>
    <String, dynamic>{
      'is_primary': instance.isPrimary,
      'name': instance.name,
      'image': instance.image,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_image_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalImageRead _$AnimalImageReadFromJson(Map<String, dynamic> json) =>
    AnimalImageRead(
      id: (json['id'] as num).toInt(),
      filename: json['filename'] as String,
      image: ImageThumbnails.fromJson(json['image'] as Map<String, dynamic>),
      isPrimary: json['is_primary'] as bool?,
    );

Map<String, dynamic> _$AnimalImageReadToJson(AnimalImageRead instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_primary': instance.isPrimary,
      'filename': instance.filename,
      'image': instance.image,
    };

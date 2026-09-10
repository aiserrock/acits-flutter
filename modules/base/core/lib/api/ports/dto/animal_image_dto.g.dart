// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalImageDto _$AnimalImageDtoFromJson(Map<String, dynamic> json) =>
    AnimalImageDto(
      id: (json['id'] as num).toInt(),
      filename: json['filename'] as String,
      image: ImageThumbnailsDto.fromJson(json['image'] as Map<String, dynamic>),
      isPrimary: json['is_primary'] as bool?,
    );

Map<String, dynamic> _$AnimalImageDtoToJson(AnimalImageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'image': instance.image.toJson(),
      'is_primary': instance.isPrimary,
    };

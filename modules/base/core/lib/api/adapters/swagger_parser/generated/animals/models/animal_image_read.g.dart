// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_image_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalImageRead _$AnimalImageReadFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['image']);
  return AnimalImageRead(
    id: AnimalImageRead._read_id(json['id']),
    isPrimary: json['is_primary'] as bool?,
    filename: json['filename'] as String?,
    image: json['image'] == null
        ? null
        : ImageThumbnails.fromJson(json['image'] as Map<String, dynamic>),
    additionalProperties:
        AnimalImageRead._extras(json, 'additionalProperties') == null
        ? const {}
        : AnimalImageRead._readExtras(
            AnimalImageRead._extras(json, 'additionalProperties'),
          ),
  );
}

Map<String, dynamic> _$AnimalImageReadToJson(AnimalImageRead instance) =>
    <String, dynamic>{
      'id': ?AnimalImageRead._write_id(instance.id),
      'is_primary': ?instance.isPrimary,
      'filename': ?instance.filename,
      'image': ?instance.image?.toJson(),
    };

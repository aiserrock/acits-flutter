// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_image_write.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalImageWrite _$AnimalImageWriteFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'image'],
    disallowNullValues: const ['name', 'image'],
  );
  return AnimalImageWrite(
    isPrimary: json['is_primary'] as bool?,
    name: json['name'] as String,
    image: json['image'] as String,
    additionalProperties:
        AnimalImageWrite._extras(json, 'additionalProperties') == null
        ? const {}
        : AnimalImageWrite._readExtras(
            AnimalImageWrite._extras(json, 'additionalProperties'),
          ),
  );
}

Map<String, dynamic> _$AnimalImageWriteToJson(AnimalImageWrite instance) =>
    <String, dynamic>{
      'is_primary': ?instance.isPrimary,
      'name': instance.name,
      'image': instance.image,
    };

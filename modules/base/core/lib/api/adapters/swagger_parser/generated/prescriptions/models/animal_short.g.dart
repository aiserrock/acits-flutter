// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalShort _$AnimalShortFromJson(Map<String, dynamic> json) => AnimalShort(
  id: AnimalShort._read_id(json['id']),
  uuid: json['uuid'] as String?,
  name: json['name'] as String?,
  specName: json['spec_name'] as String?,
  specParentName: json['spec_parent_name'] as String?,
  avatar: json['avatar'] as String?,
  defaultImageId: AnimalShort._read_defaultImageId(json['default_image_id']),
  additionalProperties:
      AnimalShort._extras(json, 'additionalProperties') == null
      ? const {}
      : AnimalShort._readExtras(
          AnimalShort._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$AnimalShortToJson(AnimalShort instance) =>
    <String, dynamic>{
      'id': ?AnimalShort._write_id(instance.id),
      'uuid': ?instance.uuid,
      'name': ?instance.name,
      'spec_name': ?instance.specName,
      'spec_parent_name': ?instance.specParentName,
      'avatar': ?instance.avatar,
      'default_image_id': ?AnimalShort._write_defaultImageId(
        instance.defaultImageId,
      ),
    };

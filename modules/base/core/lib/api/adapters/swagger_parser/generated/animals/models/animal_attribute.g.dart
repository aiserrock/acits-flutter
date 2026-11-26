// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalAttribute _$AnimalAttributeFromJson(Map<String, dynamic> json) =>
    AnimalAttribute(
      id: AnimalAttribute._read_id(json['id']),
      name: json['name'] as String?,
      isRequired: json['is_required'] as bool?,
      additionalProperties:
          AnimalAttribute._extras(json, 'additionalProperties') == null
          ? const {}
          : AnimalAttribute._readExtras(
              AnimalAttribute._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$AnimalAttributeToJson(AnimalAttribute instance) =>
    <String, dynamic>{
      'id': ?AnimalAttribute._write_id(instance.id),
      'name': ?instance.name,
      'is_required': ?instance.isRequired,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalAttribute _$AnimalAttributeFromJson(Map<String, dynamic> json) =>
    AnimalAttribute(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      isRequired: json['is_required'] as bool?,
    );

Map<String, dynamic> _$AnimalAttributeToJson(AnimalAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_required': instance.isRequired,
    };

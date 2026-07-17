// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_attribute_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalAttributeDto _$AnimalAttributeDtoFromJson(Map<String, dynamic> json) => AnimalAttributeDto(
  attrId: (json['attr_id'] as num).toInt(),
  name: json['name'] as String,
  value: json['value'] as String,
  isRequired: json['is_required'] as bool,
);

Map<String, dynamic> _$AnimalAttributeDtoToJson(AnimalAttributeDto instance) => <String, dynamic>{
  'attr_id': instance.attrId,
  'name': instance.name,
  'value': instance.value,
  'is_required': instance.isRequired,
};

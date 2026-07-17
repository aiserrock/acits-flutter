// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_attribute_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalAttributeValue _$AnimalAttributeValueFromJson(
  Map<String, dynamic> json,
) => AnimalAttributeValue(
  attrId: (json['attr_id'] as num).toInt(),
  name: json['name'] as String,
  value: json['value'] as String,
  isRequired: json['is_required'] as bool,
);

Map<String, dynamic> _$AnimalAttributeValueToJson(
  AnimalAttributeValue instance,
) => <String, dynamic>{
  'attr_id': instance.attrId,
  'name': instance.name,
  'value': instance.value,
  'is_required': instance.isRequired,
};

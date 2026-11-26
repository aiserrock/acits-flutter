// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_attribute_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalAttributeValue _$AnimalAttributeValueFromJson(
  Map<String, dynamic> json,
) => AnimalAttributeValue(
  attrId: AnimalAttributeValue._read_attrId(json['attr_id']),
  name: json['name'] as String?,
  value: json['value'] as String?,
  isRequired: json['is_required'] as bool?,
  additionalProperties:
      AnimalAttributeValue._extras(json, 'additionalProperties') == null
      ? const {}
      : AnimalAttributeValue._readExtras(
          AnimalAttributeValue._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$AnimalAttributeValueToJson(
  AnimalAttributeValue instance,
) => <String, dynamic>{
  'attr_id': ?AnimalAttributeValue._write_attrId(instance.attrId),
  'name': ?instance.name,
  'value': ?instance.value,
  'is_required': ?instance.isRequired,
};

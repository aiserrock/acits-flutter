// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeDto _$AttributeDtoFromJson(Map<String, dynamic> json) => AttributeDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  isRequired: json['is_required'] as bool?,
);

Map<String, dynamic> _$AttributeDtoToJson(AttributeDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'is_required': instance.isRequired,
};

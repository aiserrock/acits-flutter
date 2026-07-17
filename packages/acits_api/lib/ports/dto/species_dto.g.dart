// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeciesDto _$SpeciesDtoFromJson(Map<String, dynamic> json) => SpeciesDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  level: (json['level'] as num).toInt(),
  parentId: (json['parent_id'] as num?)?.toInt(),
  parentName: json['parent_name'] as String?,
  categoryName: json['category_name'] as String?,
);

Map<String, dynamic> _$SpeciesDtoToJson(SpeciesDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'level': instance.level,
  'parent_id': instance.parentId,
  'parent_name': instance.parentName,
  'category_name': instance.categoryName,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Species _$SpeciesFromJson(Map<String, dynamic> json) => Species(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  level: LevelEnum.fromJson((json['level'] as num).toInt()),
  parentName: json['parent_name'] as String?,
  categoryName: json['category_name'] as String?,
  parentId: (json['parent_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$SpeciesToJson(Species instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'level': instance.level,
  'parent_id': instance.parentId,
  'parent_name': instance.parentName,
  'category_name': instance.categoryName,
};

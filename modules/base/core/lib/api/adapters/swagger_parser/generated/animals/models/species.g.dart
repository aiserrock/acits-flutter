// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Species _$SpeciesFromJson(Map<String, dynamic> json) => Species(
  id: Species._read_id(json['id']),
  name: json['name'] as String?,
  level: !json.containsKey('level') ? null : Species._read_level(json['level']),
  parentId: Species._read_parentId(json['parent_id']),
  parentName: json['parent_name'] as String?,
  categoryName: json['category_name'] as String?,
  additionalProperties: Species._extras(json, 'additionalProperties') == null
      ? const {}
      : Species._readExtras(Species._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$SpeciesToJson(Species instance) => <String, dynamic>{
  'id': ?Species._write_id(instance.id),
  'name': ?instance.name,
  if (instance.level case final $value?) 'level': Species._write_level($value),
  'parent_id': ?Species._write_parentId(instance.parentId),
  'parent_name': ?instance.parentName,
  'category_name': ?instance.categoryName,
};

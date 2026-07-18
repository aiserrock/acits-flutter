// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalNote _$AnimalNoteFromJson(Map<String, dynamic> json) => AnimalNote(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  animal: (json['animal'] as num).toInt(),
  content: json['content'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  createdBy: json['created_by'] as String,
  updatedBy: json['updated_by'] as String,
  isUserCanEditOrDelete: json['is_user_can_edit_or_delete'] as bool,
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => AnimalNoteFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnimalNoteToJson(AnimalNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'animal': instance.animal,
      'content': instance.content,
      'files': instance.files,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'is_user_can_edit_or_delete': instance.isUserCanEditOrDelete,
    };

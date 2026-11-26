// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalNote _$AnimalNoteFromJson(Map<String, dynamic> json) => AnimalNote(
  id: AnimalNote._read_id(json['id']),
  url: json['url'] as String?,
  animal: AnimalNote._read_animal(json['animal']),
  content: json['content'] as String?,
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => AnimalNoteFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: AnimalNote._read_createdAt(json['created_at']),
  updatedAt: AnimalNote._read_updatedAt(json['updated_at']),
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  isUserCanEditOrDelete: json['is_user_can_edit_or_delete'] as bool?,
  additionalProperties: AnimalNote._extras(json, 'additionalProperties') == null
      ? const {}
      : AnimalNote._readExtras(
          AnimalNote._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$AnimalNoteToJson(AnimalNote instance) =>
    <String, dynamic>{
      'id': ?AnimalNote._write_id(instance.id),
      'url': ?instance.url,
      'animal': ?AnimalNote._write_animal(instance.animal),
      'content': ?instance.content,
      'files': ?instance.files?.map((e) => e.toJson()).toList(),
      'created_at': ?AnimalNote._write_createdAt(instance.createdAt),
      'updated_at': ?AnimalNote._write_updatedAt(instance.updatedAt),
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'is_user_can_edit_or_delete': ?instance.isUserCanEditOrDelete,
    };

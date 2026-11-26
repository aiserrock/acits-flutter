// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_animal_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedAnimalNote _$PatchedAnimalNoteFromJson(Map<String, dynamic> json) =>
    PatchedAnimalNote(
      id: PatchedAnimalNote._read_id(json['id']),
      url: json['url'] as String?,
      animal: PatchedAnimalNote._read_animal(json['animal']),
      content: json['content'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => AnimalNoteFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: PatchedAnimalNote._read_createdAt(json['created_at']),
      updatedAt: PatchedAnimalNote._read_updatedAt(json['updated_at']),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      isUserCanEditOrDelete: json['is_user_can_edit_or_delete'] as bool?,
      additionalProperties:
          PatchedAnimalNote._extras(json, 'additionalProperties') == null
          ? const {}
          : PatchedAnimalNote._readExtras(
              PatchedAnimalNote._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PatchedAnimalNoteToJson(PatchedAnimalNote instance) =>
    <String, dynamic>{
      'id': ?PatchedAnimalNote._write_id(instance.id),
      'url': ?instance.url,
      'animal': ?PatchedAnimalNote._write_animal(instance.animal),
      'content': ?instance.content,
      'files': ?instance.files?.map((e) => e.toJson()).toList(),
      'created_at': ?PatchedAnimalNote._write_createdAt(instance.createdAt),
      'updated_at': ?PatchedAnimalNote._write_updatedAt(instance.updatedAt),
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'is_user_can_edit_or_delete': ?instance.isUserCanEditOrDelete,
    };

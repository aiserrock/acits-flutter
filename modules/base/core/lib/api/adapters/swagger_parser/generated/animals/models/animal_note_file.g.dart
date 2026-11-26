// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_note_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalNoteFile _$AnimalNoteFileFromJson(Map<String, dynamic> json) =>
    AnimalNoteFile(
      id: AnimalNoteFile._read_id(json['id']),
      file: json['file'] as String?,
      name: json['name'] as String?,
      filename: json['filename'] as String?,
      createdAt: AnimalNoteFile._read_createdAt(json['created_at']),
      additionalProperties:
          AnimalNoteFile._extras(json, 'additionalProperties') == null
          ? const {}
          : AnimalNoteFile._readExtras(
              AnimalNoteFile._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$AnimalNoteFileToJson(AnimalNoteFile instance) =>
    <String, dynamic>{
      'id': ?AnimalNoteFile._write_id(instance.id),
      'file': ?instance.file,
      'name': ?instance.name,
      'filename': ?instance.filename,
      'created_at': ?AnimalNoteFile._write_createdAt(instance.createdAt),
    };

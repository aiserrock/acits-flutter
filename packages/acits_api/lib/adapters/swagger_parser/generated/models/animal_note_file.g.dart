// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_note_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalNoteFile _$AnimalNoteFileFromJson(Map<String, dynamic> json) =>
    AnimalNoteFile(
      id: (json['id'] as num).toInt(),
      file: json['file'] as String,
      name: json['name'] as String,
      filename: json['filename'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AnimalNoteFileToJson(AnimalNoteFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'name': instance.name,
      'filename': instance.filename,
      'created_at': instance.createdAt.toIso8601String(),
    };

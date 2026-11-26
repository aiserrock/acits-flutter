// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_note_file_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalNoteFileDto _$AnimalNoteFileDtoFromJson(Map<String, dynamic> json) =>
    AnimalNoteFileDto(
      id: (json['id'] as num).toInt(),
      file: json['file'] as String,
      name: json['name'] as String,
      filename: json['filename'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AnimalNoteFileDtoToJson(AnimalNoteFileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'name': instance.name,
      'filename': instance.filename,
      'created_at': instance.createdAt.toIso8601String(),
    };

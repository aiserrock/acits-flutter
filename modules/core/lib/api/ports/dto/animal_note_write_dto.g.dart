// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_note_write_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalNoteFileWriteDto _$AnimalNoteFileWriteDtoFromJson(Map<String, dynamic> json) =>
    AnimalNoteFileWriteDto(name: json['name'] as String, file: json['file'] as String);

Map<String, dynamic> _$AnimalNoteFileWriteDtoToJson(AnimalNoteFileWriteDto instance) => <String, dynamic>{
  'name': instance.name,
  'file': instance.file,
};

AnimalNoteWriteDto _$AnimalNoteWriteDtoFromJson(Map<String, dynamic> json) => AnimalNoteWriteDto(
  animal: (json['animal'] as num).toInt(),
  content: json['content'] as String,
  id: (json['id'] as num?)?.toInt(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => AnimalNoteFileWriteDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnimalNoteWriteDtoToJson(AnimalNoteWriteDto instance) => <String, dynamic>{
  'id': ?instance.id,
  'animal': instance.animal,
  'content': instance.content,
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

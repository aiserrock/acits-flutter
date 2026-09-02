// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'animal_note_file.g.dart';

/// AnimalNoteFile serializer.
@JsonSerializable()
class AnimalNoteFile {
  const AnimalNoteFile({
    this.id,
    this.file,
    this.name,
    this.filename,
    this.createdAt,
  });
  
  factory AnimalNoteFile.fromJson(Map<String, Object?> json) => _$AnimalNoteFileFromJson(json);
  
  final int? id;
  final String? file;
  final String? name;
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, Object?> toJson() => _$AnimalNoteFileToJson(this);
}

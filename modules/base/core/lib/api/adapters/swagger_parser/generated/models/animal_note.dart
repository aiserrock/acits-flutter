// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'animal_note_file.dart';

part 'animal_note.g.dart';

/// AnimalNote serializer.
@JsonSerializable()
class AnimalNote {
  const AnimalNote({
    this.id,
    this.url,
    this.animal,
    this.content,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isUserCanEditOrDelete,
  });
  
  factory AnimalNote.fromJson(Map<String, Object?> json) => _$AnimalNoteFromJson(json);
  
  final int? id;
  final String? url;
  final int? animal;
  final String? content;
  final List<AnimalNoteFile>? files;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;

  /// SerializerMethodField method.
  @JsonKey(name: 'is_user_can_edit_or_delete')
  final bool? isUserCanEditOrDelete;

  Map<String, Object?> toJson() => _$AnimalNoteToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import 'animal_note_file_dto.dart';

part 'animal_note_dto.g.dart';

/// An animal note / comment (read shape).
///
/// OUR DTO — mirrors `AnimalNote`. [isUserCanEditOrDelete] is a server-computed
/// permission flag. Nullability is defensive: real payloads may omit metadata.
@JsonSerializable()
class AnimalNoteDto {
  const AnimalNoteDto({
    required this.id,
    required this.animal,
    required this.content,
    this.url,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isUserCanEditOrDelete,
  });

  factory AnimalNoteDto.fromJson(Map<String, dynamic> json) => _$AnimalNoteDtoFromJson(json);

  final int id;
  final String? url;
  final int animal;
  final String content;
  final List<AnimalNoteFileDto>? files;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'is_user_can_edit_or_delete')
  final bool? isUserCanEditOrDelete;

  Map<String, dynamic> toJson() => _$AnimalNoteDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalNoteDto &&
          other.id == id &&
          other.animal == animal &&
          other.content == content &&
          other.createdAt == createdAt;

  @override
  int get hashCode => Object.hash(id, animal, content, createdAt);
}

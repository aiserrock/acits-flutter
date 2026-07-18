import 'package:json_annotation/json_annotation.dart';

part 'animal_note_file_dto.g.dart';

/// A file attached to an animal note (read shape).
///
/// OUR DTO — mirrors `AnimalNoteFile`. [file] carries the URL on read.
@JsonSerializable()
class AnimalNoteFileDto {
  const AnimalNoteFileDto({
    required this.id,
    required this.file,
    required this.name,
    required this.filename,
    required this.createdAt,
  });

  factory AnimalNoteFileDto.fromJson(Map<String, dynamic> json) => _$AnimalNoteFileDtoFromJson(json);

  final int id;
  final String file;
  final String name;
  final String filename;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$AnimalNoteFileDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalNoteFileDto &&
          other.id == id &&
          other.file == file &&
          other.name == name &&
          other.filename == filename &&
          other.createdAt == createdAt;

  @override
  int get hashCode => Object.hash(id, file, name, filename, createdAt);
}

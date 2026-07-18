import 'package:json_annotation/json_annotation.dart';

part 'animal_note_write_dto.g.dart';

/// A file to attach when creating/updating an animal note (write shape).
///
/// OUR DTO. [file] carries the base64 data URI the backend expects.
@JsonSerializable(includeIfNull: false)
class AnimalNoteFileWriteDto {
  const AnimalNoteFileWriteDto({required this.name, required this.file});

  factory AnimalNoteFileWriteDto.fromJson(Map<String, dynamic> json) => _$AnimalNoteFileWriteDtoFromJson(json);

  final String name;

  /// Base64 data URI payload (e.g. `data:application/pdf;base64,...`).
  final String file;

  Map<String, dynamic> toJson() => _$AnimalNoteFileWriteDtoToJson(this);
}

/// An animal note create/update payload.
///
/// OUR DTO — mirrors `AnimalNote`/`PatchedAnimalNote` write shape. [id] is set
/// only on patch.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AnimalNoteWriteDto {
  const AnimalNoteWriteDto({required this.animal, required this.content, this.id, this.files});

  factory AnimalNoteWriteDto.fromJson(Map<String, dynamic> json) => _$AnimalNoteWriteDtoFromJson(json);

  final int? id;
  final int animal;
  final String content;
  final List<AnimalNoteFileWriteDto>? files;

  Map<String, dynamic> toJson() => _$AnimalNoteWriteDtoToJson(this);
}

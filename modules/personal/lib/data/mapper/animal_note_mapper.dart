import 'package:core/api.dart' show AnimalNoteDto, AnimalNoteFileDto;
import 'package:core/domain.dart' show Transformable;

import 'package:personal/domain/domain.dart';

/// DTO → [AnimalNote]. Отдельный класс-маппер (Transformable), а не метод на
/// DTO: домен про DTO не знает.
class AnimalNoteMapper implements Transformable<AnimalNote> {
  const AnimalNoteMapper(this._dto);

  final AnimalNoteDto _dto;

  @override
  AnimalNote toEntity() => AnimalNote(
    id: _dto.id,
    url: _dto.url,
    animal: _dto.animal,
    content: _dto.content,
    files: _dto.files?.map((f) => AnimalNoteFileMapper(f).toEntity()).toList(growable: false),
    createdAt: _dto.createdAt,
    updatedAt: _dto.updatedAt,
    createdBy: _dto.createdBy,
    updatedBy: _dto.updatedBy,
    isUserCanEditOrDelete: _dto.isUserCanEditOrDelete,
  );
}

/// DTO → [AnimalNoteFile].
class AnimalNoteFileMapper implements Transformable<AnimalNoteFile> {
  const AnimalNoteFileMapper(this._dto);

  final AnimalNoteFileDto _dto;

  @override
  AnimalNoteFile toEntity() =>
      AnimalNoteFile(id: _dto.id, file: _dto.file, name: _dto.name, filename: _dto.filename, createdAt: _dto.createdAt);
}

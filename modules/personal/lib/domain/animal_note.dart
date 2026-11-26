import 'animal_note_file.dart';

/// Доменная модель заметки/комментария к животному.
///
/// Не зависит от `gen/api`. [isUserCanEditOrDelete] — вычисленный сервером флаг
/// прав. Nullability защитная: реальные payload-ы могут опускать метаданные.
class AnimalNote {
  const AnimalNote({
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

  final int id;
  final String? url;
  final int animal;
  final String content;
  final List<AnimalNoteFile>? files;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isUserCanEditOrDelete;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalNote &&
          other.id == id &&
          other.animal == animal &&
          other.content == content &&
          other.createdAt == createdAt;

  @override
  int get hashCode => Object.hash(id, animal, content, createdAt);
}

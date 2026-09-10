/// Доменная модель файла, прикреплённого к заметке животного (чтение).
class AnimalNoteFile {
  const AnimalNoteFile({
    required this.id,
    required this.file,
    required this.name,
    required this.filename,
    required this.createdAt,
  });

  final int id;
  final String file;
  final String name;
  final String filename;
  final DateTime createdAt;
}

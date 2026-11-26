/// Доменная модель файла, прикреплённого к назначению.
class PrescriptionFile {
  const PrescriptionFile({required this.file, this.id, this.name, this.filename, this.createdAt});

  final int? id;

  /// URL (чтение) либо base64 data URI (запись).
  final String file;
  final String? name;
  final String? filename;
  final DateTime? createdAt;
}

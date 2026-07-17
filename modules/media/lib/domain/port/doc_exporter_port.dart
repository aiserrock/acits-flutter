import 'dart:typed_data';

/// Порт экспорта документа наружу («поделиться» / «скачать»).
///
/// Реализация — платформенная (io / web / stub через conditional import) —
/// живёт в приложении как инфраструктура и мостится в модуль. Медиа-экран
/// просмотрщика PDF зависит только от этой абстракции, не от dart:html / io.
abstract interface class DocExporterPort {
  /// Отдать [bytes] наружу под именем [fileName] (например, «animal_42.pdf»).
  /// [mimeType] по умолчанию — PDF. [text]/[subject] — необязательная подпись
  /// для share-sheet (где поддерживается).
  Future<void> share(
    Uint8List bytes, {
    required String fileName,
    String mimeType = 'application/pdf',
    String? text,
    String? subject,
  });

  /// Просто скачать [bytes] в файл [fileName], без share-sheet.
  Future<void> download(Uint8List bytes, {required String fileName, String mimeType = 'application/pdf'});
}

import 'dart:typed_data';

import 'doc_exporter_stub.dart'
    if (dart.library.js_interop) 'doc_exporter_web.dart'
    if (dart.library.io) 'doc_exporter_io.dart';

/// Экспорт документа наружу («поделиться» / «скачать»).
///
/// Единственная операция PDF-конвейера, которая по-настоящему различается между
/// платформами: mobile отдаёт файл через системный share-sheet (ACTION_SEND),
/// web — через Web Share API или скачивание blob. Рендер и загрузка PDF
/// универсальны и байтовые; разница изолирована здесь, за одним интерфейсом,
/// чтобы остальная логика оставалась общей и одинаково дебажилась.
abstract interface class DocExporter {
  /// Создаёт платформенную реализацию (conditional import: web / io / stub).
  factory DocExporter() = DocExporterImpl;

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

import 'dart:convert';
import 'dart:typed_data';

/// Провайдер байтов PDF-документа. Байты (а не File) — единый кроссплатформенный
/// формат: `pdfx` рендерит их через `PdfDocument.openData` на всех платформах,
/// включая web, где файловой системы нет. Раньше здесь был
/// `Future<File> Function()`, что жёстко привязывало просмотр PDF к mobile.
typedef PdfDocFetcher = Future<Uint8List> Function();

mixin PdfDocumentMixin {
  /// Декодировать тело PDF в байты. Бэк отдаёт PDF строкой (`Response<String>`):
  /// сначала пробуем base64, иначе трактуем строку как latin1 (round-trip
  /// байт 1:1). Диск не задействуется — байты остаются в памяти и идут прямо в
  /// рендерер/шаринг, что одинаково работает и в web, и на устройстве.
  Uint8List decodePdfBytes(String raw) {
    try {
      return base64Decode(raw);
    } on FormatException {
      return Uint8List.fromList(latin1.encode(raw));
    }
  }
}

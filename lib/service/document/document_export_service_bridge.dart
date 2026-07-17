import 'dart:typed_data';

import 'package:acits_core/acits_core.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/service/document/doc_exporter/doc_exporter.dart';
import 'package:acits_flutter/service/document/share_text/share_text_stub.dart'
    if (dart.library.js_interop) 'package:acits_flutter/service/document/share_text/share_text_web.dart'
    if (dart.library.io) 'package:acits_flutter/service/document/share_text/share_text_io.dart';

/// Реализация порта [DocumentExportService] (acits_core) поверх существующего
/// [DocExporter] приложения (io/web conditional import уже внутри него).
///
/// Регистрируется в DI рядом с текущим стеком; фичи пока используют [DocExporter]
/// напрямую — этот порт нужен новому базису и появляется до потребителей.
///
/// Покрытие: [shareText]/[shareImage]/[sharePdf] реально работают на обеих
/// платформах. [printPdf] проекту сейчас не нужен (нет зависимости `printing`)
/// и делегирует в share PDF как разумный фолбэк — TODO завести реальный print,
/// когда появится потребитель.
@Injectable(as: DocumentExportService)
class DocumentExportServiceBridge implements DocumentExportService {
  DocumentExportServiceBridge() : _exporter = DocExporter();

  final DocExporter _exporter;

  @override
  Future<void> shareText(String text) => shareTextPlatform(text);

  @override
  Future<void> shareImage(Uint8List bytes, String filename) => _exporter.share(
    bytes,
    fileName: filename,
    mimeType: _mimeFor(filename, fallback: 'image/png'),
  );

  @override
  Future<void> sharePdf(Uint8List bytes, String filename) =>
      _exporter.share(bytes, fileName: filename, mimeType: 'application/pdf');

  // TODO(step7): реальный print (пакет `printing`) — когда появится потребитель.
  // Пока фолбэк на share PDF, чтобы порт был рабочим, а не бросал.
  @override
  Future<void> printPdf(Uint8List bytes) => _exporter.share(bytes, fileName: 'document.pdf');

  String _mimeFor(String filename, {required String fallback}) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return 'image/jpeg';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    if (lower.endsWith('.pdf')) return 'application/pdf';
    return fallback;
  }
}

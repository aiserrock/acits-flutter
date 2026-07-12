import 'dart:typed_data';

import 'package:acits_flutter/service/document/doc_exporter/doc_exporter.dart';

/// Заглушка [DocExporter] для платформ без dart:io и без js_interop.
/// Реально не выбирается (conditional import всегда резолвится в io или web).
class DocExporterImpl implements DocExporter {
  @override
  Future<void> share(
    Uint8List bytes, {
    required String fileName,
    String mimeType = 'application/pdf',
    String? text,
    String? subject,
  }) async {
    throw UnsupportedError('DocExporter is not supported on this platform');
  }
}

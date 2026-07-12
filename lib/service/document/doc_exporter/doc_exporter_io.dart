import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

import 'package:acits_flutter/service/document/doc_exporter/doc_exporter.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Mobile/desktop-реализация [DocExporter]: системный share-sheet (ACTION_SEND
/// на Android, UIActivityViewController на iOS) через share_plus. Байты
/// оборачиваются в `XFile.fromData` — файл на диск не пишется.
class DocExporterImpl implements DocExporter {
  @override
  Future<void> share(
    Uint8List bytes, {
    required String fileName,
    String mimeType = 'application/pdf',
    String? text,
    String? subject,
  }) async {
    Log.debug('DocExporter(io).share: $fileName ${bytes.lengthInBytes}B');
    final file = XFile.fromData(bytes, mimeType: mimeType, name: fileName);
    await SharePlus.instance.share(
      ShareParams(files: [file], text: text, subject: subject, fileNameOverrides: [fileName]),
    );
  }
}

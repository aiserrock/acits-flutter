import 'dart:io';
import 'dart:typed_data';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:acits_flutter/service/document/doc_exporter/doc_exporter.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Mobile/desktop-реализация [DocExporter]: системный share-sheet (ACTION_SEND
/// на Android, UIActivityViewController на iOS) через share_plus.
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

  /// Пишет файл в temp и открывает системным вьювером — оттуда юзер сохранит.
  @override
  Future<void> download(
    Uint8List bytes, {
    required String fileName,
    String mimeType = 'application/pdf',
  }) async {
    Log.info('DocExporter(io).download: $fileName ${bytes.lengthInBytes}B');
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/$fileName';
    await File(path).writeAsBytes(bytes, flush: true);
    await OpenFilex.open(path, type: mimeType);
  }
}

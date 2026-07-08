import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

const _pdfExtension = '.pdf';

typedef PdfDocFetcher = Future<File> Function();

mixin PdfDocumentMixin {
  /// Конвертировать строку Base64 в файл и сохранить его в ФС
  Future<File> convertPdfStringToFile(String raw, {required String fileName}) async {
    // Оставляем только имя файла, отсекая любые разделители пути и обход директорий
    fileName = fileName.split(RegExp(r'[/\\]')).last.replaceAll('..', '');
    if (fileName.isEmpty) fileName = 'document';
    if (!(fileName.contains('.'))) fileName = '$fileName$_pdfExtension';
    final dir = (await getTemporaryDirectory()).absolute.path;
    final path = '$dir/$fileName';

    final file = File(path);
    // Тело PDF приходит строкой (Response<String>). Пытаемся декодировать как base64,
    // иначе трактуем строку как latin1 (round-trip байт 1:1).
    final bytes = _decodePdfBytes(raw);
    await file.writeAsBytes(bytes);
    return file;

    // final bytes = base64.decode(rawFile.fileBody!);

    // final fileName =
    //     rawFile.fileName?.replaceFirst(overrideExtension ?? _pdfExtension, '').replaceAll('/', '_');
    // final path = await createNewFilePath(fileName, overrideExtension: overrideExtension);
    // final file = File(path);
    // await file.writeAsBytes(bytes);
    // return FileEntity.file(file, fileName: fileName);
  }

  /// Декодировать тело PDF: сначала пробуем base64, иначе latin1 (round-trip байт 1:1).
  List<int> _decodePdfBytes(String raw) {
    try {
      return base64Decode(raw);
    } on FormatException {
      return latin1.encode(raw);
    }
  }
}

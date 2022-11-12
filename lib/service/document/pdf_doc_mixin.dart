import 'dart:io';

import 'package:path_provider/path_provider.dart';

const _pdfExtension = '.pdf';

typedef PdfDocFetcher = Future<File> Function();

mixin PdfDocumentMixin {
  /// Конвертировать строку Base64 в файл и сохранить его в ФС
  Future<File> convertPdfStringToFile(String raw, {required String fileName}) async {
    if (!(fileName.contains('.'))) fileName = '$fileName$_pdfExtension';
    final dir = (await getTemporaryDirectory()).absolute.path;
    fileName = '$dir/$fileName';

    final file = File(fileName);
    final bytes = raw.codeUnits;
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
}

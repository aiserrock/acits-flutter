import 'dart:typed_data';

abstract interface class DocumentExportService {
  Future<void> shareText(String text);
  Future<void> shareImage(Uint8List bytes, String filename);
  Future<void> sharePdf(Uint8List bytes, String filename);
  Future<void> printPdf(Uint8List bytes);
}

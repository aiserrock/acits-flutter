import 'dart:typed_data';

abstract interface class FileDownloadService {
  Future<void> download(Uint8List bytes, String filename);
}

class WebInsets {
  const WebInsets({required this.top, required this.bottom, required this.left, required this.right});

  final double top;
  final double bottom;
  final double left;
  final double right;
}

abstract interface class WebInsetsProvider {
  WebInsets get insets;
}

abstract interface class StandaloneModeDetector {
  /// true, если приложение запущено как установленная (standalone) PWA.
  bool get isStandalone;
}

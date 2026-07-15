import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

import 'package:acits_flutter/service/document/doc_exporter/doc_exporter.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Web-реализация [DocExporter]: сначала Web Share API (share-sheet как на
/// мобильном), иначе фолбэк на скачивание через `<a download>`.
class DocExporterImpl implements DocExporter {
  @override
  Future<void> share(
    Uint8List bytes, {
    required String fileName,
    String mimeType = 'application/pdf',
    String? text,
    String? subject,
  }) async {
    Log.info('[share] старт: $fileName ${bytes.lengthInBytes}B');
    final blob = _blobOf(bytes, mimeType);
    if (await _tryNativeShare(blob, fileName, mimeType)) return;
    Log.info('[share] фолбэк: скачивание $fileName');
    _download(blob, fileName);
  }

  @override
  Future<void> download(Uint8List bytes, {required String fileName, String mimeType = 'application/pdf'}) async {
    Log.info('[download] $fileName ${bytes.lengthInBytes}B');
    _download(_blobOf(bytes, mimeType), fileName);
  }

  web.Blob _blobOf(Uint8List bytes, String mimeType) {
    final parts = [bytes.toJS].toJS;
    return web.Blob(parts, web.BlobPropertyBag(type: mimeType));
  }

  /// Шарит файл через Web Share API. true — share вызван (или отменён юзером);
  /// false — API/файлы не поддержаны, нужен фолбэк на скачивание.
  Future<bool> _tryNativeShare(web.Blob blob, String fileName, String mimeType) async {
    final navigator = web.window.navigator;
    if (!navigator.has('share') || !navigator.has('canShare')) {
      Log.warning('[share] нет Web Share API → скачивание');
      return false;
    }

    final file = web.File([blob].toJS, fileName, web.FilePropertyBag(type: mimeType));
    // Только `files`, без text/title: смешанный share ломает вложение в Telegram.
    final data = web.ShareData(files: [file].toJS);

    // Диагностика для talker: что уходит в share-sheet и берёт ли его браузер.
    Log.info('[share] файл=${file.name} type=${file.type} size=${file.size}B');
    Log.info('[share] ua=${navigator.userAgent}');

    if (!navigator.canShare(data)) {
      Log.warning('[share] canShare(files)=false → скачивание');
      return false;
    }

    try {
      await navigator.share(data).toDart;
      // Успех API ≠ файл дошёл: получатель (Telegram/VK) мог молча отбросить.
      Log.info('[share] navigator.share успешно вызван для ${file.name}');
      return true;
    } catch (e) {
      if (e.toString().contains('AbortError')) {
        Log.info('[share] отменён пользователем');
        return true;
      }
      Log.error('[share] ошибка navigator.share → скачивание', e);
      return false;
    }
  }

  void _download(web.Blob blob, String fileName) {
    try {
      final url = web.URL.createObjectURL(blob);
      final anchor = web.HTMLAnchorElement()
        ..href = url
        ..download = fileName
        ..style.display = 'none';
      web.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      // Освобождаем blob-URL после клика (файл уже начал скачиваться).
      web.URL.revokeObjectURL(url);
      Log.info('[download] <a download> клик выполнен: $fileName');
    } catch (e, s) {
      Log.error('[download] ошибка скачивания через <a>: $fileName', e, s);
    }
  }
}

/// Расширение-хелпер: есть ли у navigator метод/свойство с данным именем.
extension on web.Navigator {
  bool has(String prop) => (this as JSObject).has(prop);
}

extension on JSObject {
  bool has(String prop) => hasProperty(prop.toJS).toDart;
}

import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

import 'package:acits_flutter/service/document/doc_exporter/doc_exporter.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Web-реализация [DocExporter].
///
/// Приоритет — нативный Web Share API (`navigator.share` с файлом): в
/// standalone-PWA на iOS/Android открывает системный share-sheet, как на
/// мобильном. Где он недоступен или не умеет файлы (десктоп-браузеры) —
/// фолбэк на скачивание через временный `<a download>` по blob-URL.
class DocExporterImpl implements DocExporter {
  @override
  Future<void> share(
    Uint8List bytes, {
    required String fileName,
    String mimeType = 'application/pdf',
    String? text,
    String? subject,
  }) async {
    Log.debug('DocExporter(web).share: $fileName ${bytes.lengthInBytes}B');

    final blob = _blobOf(bytes, mimeType);

    if (await _tryNativeShare(blob, fileName, mimeType, text, subject)) return;

    // Фолбэк: скачивание файла.
    _download(blob, fileName);
  }

  web.Blob _blobOf(Uint8List bytes, String mimeType) {
    final parts = [bytes.toJS].toJS;
    return web.Blob(parts, web.BlobPropertyBag(type: mimeType));
  }

  /// Пытается поделиться через Web Share API level 2 (файлы). Возвращает true,
  /// если share прошёл; false — если API/поддержки файлов нет (нужен фолбэк).
  /// Отмену пользователем (AbortError) трактуем как «обработано» — не качаем.
  Future<bool> _tryNativeShare(
    web.Blob blob,
    String fileName,
    String mimeType,
    String? text,
    String? subject,
  ) async {
    final navigator = web.window.navigator;
    // canShare({files}) — единственная надёжная проверка поддержки share файлов.
    if (!navigator.has('share') || !navigator.has('canShare')) return false;

    final file = web.File([blob].toJS, fileName, web.FilePropertyBag(type: mimeType));
    final data = web.ShareData(files: [file].toJS, text: text ?? '', title: subject ?? fileName);

    if (!navigator.canShare(data)) return false;

    try {
      await navigator.share(data).toDart;
      return true;
    } catch (e) {
      // AbortError — пользователь закрыл share-лист; это успех сценария, не
      // качаем. Отличаем по тексту ошибки (без ненадёжного is-check JS-типов).
      // Прочие ошибки (NotAllowedError/DataError, share файлов недоступен на
      // десктопе даже при canShare==true) — фолбэк на скачивание.
      if (e.toString().contains('AbortError')) return true;
      Log.warning('Web share failed, fallback to download: $e');
      return false;
    }
  }

  void _download(web.Blob blob, String fileName) {
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
  }
}

/// Расширение-хелпер: есть ли у navigator метод/свойство с данным именем.
extension on web.Navigator {
  bool has(String prop) => (this as JSObject).has(prop);
}

extension on JSObject {
  bool has(String prop) => hasProperty(prop.toJS).toDart;
}

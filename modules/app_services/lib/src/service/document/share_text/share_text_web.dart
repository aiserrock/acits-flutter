import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

/// web: Web Share API с текстом; при отсутствии — копирование в буфер обмена
/// как безопасный фолбэк (share текста без файла поддержан большинством
/// браузеров, clipboard — универсальный запасной путь).
Future<void> shareTextPlatform(String text) async {
  final navigator = web.window.navigator;
  if ((navigator as JSObject).hasProperty('share'.toJS).toDart) {
    try {
      await navigator.share(web.ShareData(text: text)).toDart;
      return;
    } catch (_) {
      // Отмена/ошибка — уходим на clipboard-фолбэк.
    }
  }
  await navigator.clipboard.writeText(text).toDart;
}

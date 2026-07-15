import 'package:web/web.dart' as web;

/// Web-реализация: удаляет DOM-splash из `web/index.html`.
///
/// `#splash` — картинка логотипа на фоне #6776E0, `#loader` — CSS-спиннер.
/// Они показываются мгновенно (до загрузки Flutter) и держатся, пока Flutter
/// рисует такой же #6776E0-кадр на splash-роуте. Убираем их в тот момент, когда
/// уходим со splash на root/login — переход получается бесшовным (фон совпадает).
void removeSplash() {
  for (final id in const ['splash', 'loader']) {
    web.document.getElementById(id)?.remove();
  }
}

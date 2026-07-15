import 'pdfjs_ready_stub.dart'
    if (dart.library.js_interop) 'pdfjs_ready_web.dart'
    if (dart.library.io) 'pdfjs_ready_stub.dart';

/// Готовность pdf.js (глобальный `pdfjsLib`) к работе.
///
/// На web пакет `pdfx` подключается через ES-модуль в `index.html`, который
/// из-за `type="module"` исполняется отложенно — после синхронного
/// `main.dart.js`. Поэтому первый заход в просмотрщик может опередить загрузку
/// pdf.js, и рендерер бросит «Pdfjs library not loaded». [ensure] ждёт, пока
/// `pdfjsLib` появится. На mobile/desktop pdf.js не используется — no-op.
abstract final class PdfjsReady {
  /// Дождаться загрузки pdf.js (web) или сразу вернуться (остальные платформы).
  static Future<void> ensure() => pdfjsEnsureReady();
}

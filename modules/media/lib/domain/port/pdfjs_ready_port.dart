/// Порт готовности pdf.js (web) к работе.
///
/// На web пакет `pdfx` подключается через ES-модуль в `index.html`, который
/// исполняется отложенно; первый заход в просмотрщик может опередить загрузку
/// pdf.js. Реализация (conditional import web/stub) — инфраструктура приложения,
/// мостится в модуль. На mobile/desktop — no-op.
abstract interface class PdfjsReadyPort {
  /// Дождаться загрузки pdf.js (web) или сразу вернуться (остальные платформы).
  Future<void> ensure();
}

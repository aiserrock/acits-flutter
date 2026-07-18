/// Safe-area insets для web (iOS PWA) через JS-библиотеку safe-area-insets.
///
/// Flutter web НЕ пробрасывает `env(safe-area-inset-*)` в `MediaQuery`, поэтому
/// нижний home-indicator на iOS-PWA перекрывает нав-бар. `web/js/webinsets.min.js`
/// (safe-area-insets, pengfeiw) измеряет реальные insets и кладёт в
/// `window.safeAreaInsets`; здесь читаем их через JS-interop.
///
/// На нативных платформах — заглушка (нули): там inset приходит от ОС штатно
/// через `MediaQuery.viewPadding`, JS-либа не нужна.
library;

export 'web_insets_stub.dart' if (dart.library.js_interop) 'web_insets_web.dart';

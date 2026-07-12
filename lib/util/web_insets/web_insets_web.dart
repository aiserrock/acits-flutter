import 'dart:js_interop';

/// Web-реализация [WebInsets]: читает `window.safeAreaInsets` из
/// `web/js/webinsets.min.js` (библиотека safe-area-insets).
///
/// Геттеры возвращают число или NaN (если библиотека ещё не измерила / не
/// поддерживается) — NaN приводим к 0.
@JS('safeAreaInsets')
external _SafeAreaInsets? get _safeAreaInsets;

@JS()
@staticInterop
class _SafeAreaInsets {}

extension _SafeAreaInsetsExt on _SafeAreaInsets {
  external double get top;
  external double get bottom;
  external double get left;
  external double get right;
  external void onChange(JSFunction callback);
}

double _clean(double? v) => (v == null || v.isNaN) ? 0 : v;

abstract final class WebInsets {
  static double get bottom => _clean(_safeAreaInsets?.bottom);

  static double get top => _clean(_safeAreaInsets?.top);

  static double get left => _clean(_safeAreaInsets?.left);

  static double get right => _clean(_safeAreaInsets?.right);

  /// Подписка на изменение insets (первый замер запаздывает, плюс повороты
  /// экрана). Колбэк дёргается библиотекой; аргумент игнорируем — читаем
  /// свежие значения через геттеры.
  static void onChange(void Function() callback) {
    _safeAreaInsets?.onChange(((JSAny _) => callback()).toJS);
  }
}

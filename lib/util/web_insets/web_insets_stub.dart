/// Нативная заглушка [WebInsets]: на mobile/desktop safe-area приходит от ОС
/// через `MediaQuery.viewPadding`, JS-измерение не нужно — возвращаем нули.
abstract final class WebInsets {
  static double get bottom => 0;

  static double get top => 0;

  static double get left => 0;

  static double get right => 0;

  static bool get isStandalone => false;

  static String get debugInfo => '';

  /// На нативе insets не меняются через JS — no-op.
  static void onChange(void Function() callback) {}
}

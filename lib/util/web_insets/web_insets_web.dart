import 'dart:js_interop';

/// Web-реализация [WebInsets]: читает `window.safeAreaInsets` из
/// `web/js/webinsets.min.js` (библиотека safe-area-insets) + fallback для
/// iOS-standalone, где `env(safe-area-inset)` иногда стабильно 0.
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

@JS('navigator.standalone')
external JSBoolean? get _navStandalone;

@JS('navigator.userAgent')
external String get _userAgent;

@JS('window.matchMedia')
external _MediaQueryList _matchMedia(String query);

@JS()
@staticInterop
class _MediaQueryList {}

extension _MediaQueryListExt on _MediaQueryList {
  external bool get matches;
}

@JS('window.innerHeight')
external double get _innerHeight;

double _clean(double? v) => (v == null || v.isNaN) ? 0 : v;

/// iOS home-indicator ≈ 34 логических px. Fallback, когда PWA в standalone,
/// устройство — iPhone с «чёлкой»/индикатором, а библиотека вернула 0.
const _iosHomeIndicator = 34.0;

abstract final class WebInsets {
  /// PWA запущено как standalone (добавлено на домашний экран).
  static bool get isStandalone {
    final nav = _navStandalone?.toDart ?? false;
    var mm = false;
    try {
      mm = _matchMedia('(display-mode: standalone)').matches;
    } catch (_) {}
    return nav || mm;
  }

  static bool get _isIosTallDevice {
    final ua = _userAgent.toLowerCase();
    final isIos = ua.contains('iphone') || ua.contains('ipad') || ua.contains('ipod');
    // iPhone c home-indicator — высокие экраны; грубый порог по высоте.
    return isIos && _innerHeight >= 700;
  }

  static double get bottom {
    final measured = _clean(_safeAreaInsets?.bottom);
    if (measured > 0) return measured;
    // Fallback: библиотека/env вернули 0, но это standalone iOS-устройство с
    // индикатором — подставляем типовую высоту, чтобы нав-бар не прилипал.
    if (isStandalone && _isIosTallDevice) return _iosHomeIndicator;
    return 0;
  }

  static double get top => _clean(_safeAreaInsets?.top);

  static double get left => _clean(_safeAreaInsets?.left);

  static double get right => _clean(_safeAreaInsets?.right);

  /// Диагностическая строка (видна в AppVersionLabel на web) — чтобы понять на
  /// реальном устройстве, что возвращают либа/браузер.
  static String get debugInfo {
    final raw = _clean(_safeAreaInsets?.bottom);
    return 'sa=${bottom.toStringAsFixed(0)} raw=${raw.toStringAsFixed(0)} '
        'sb=${isStandalone ? 1 : 0} h=${_innerHeight.toStringAsFixed(0)}';
  }

  /// Подписка на изменение insets. JS-либа не умеет removeListener, поэтому
  /// отписка реализована guard-флагом в замыкании: возвращённый [VoidCallback]
  /// глушит колбэк, чтобы уже размонтированный виджет не дёргал setState.
  static void Function() onChange(void Function() callback) {
    var active = true;
    _safeAreaInsets?.onChange(
      (((JSAny _) {
        if (active) callback();
      })).toJS,
    );
    return () => active = false;
  }
}

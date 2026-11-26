import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:ui_kit/ui_kit.dart' show Breakpoints;

/// Портретная ориентация только на телефонах. На планшетах, складных устройствах
/// и в окнах ориентация свободна: интерфейс там адаптивный, а Android 16 всё равно
/// игнорирует блокировку на больших экранах.
abstract final class OrientationPolicy {
  /// Допустимые ориентации для экрана с короткой стороной [shortestSide] (логические px).
  static List<DeviceOrientation> forShortestSide(double shortestSide) =>
      shortestSide < Breakpoints.medium ? const [DeviceOrientation.portraitUp] : const [];

  /// Применяет политику к текущему устройству. Пустой список снимает блокировку.
  static Future<void> apply() {
    final view = PlatformDispatcher.instance.views.first;
    final shortestSide = view.physicalSize.shortestSide / view.devicePixelRatio;
    return SystemChrome.setPreferredOrientations(forShortestSide(shortestSide));
  }
}

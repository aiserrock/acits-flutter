/// Пороги адаптива (M3 window size classes).
abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 840;
  static const double large = 1200;
}

/// Классы ширины окна. Порядок = возрастание ширины.
enum WindowSize {
  compact,
  medium,
  expanded,
  large;

  /// Классификация по ширине в логических пикселях.
  static WindowSize fromWidth(double width) {
    if (width >= Breakpoints.large) return WindowSize.large;
    if (width >= Breakpoints.expanded) return WindowSize.expanded;
    if (width >= Breakpoints.medium) return WindowSize.medium;
    return WindowSize.compact;
  }
}

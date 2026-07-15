import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Тема оформления приложения (Material 3).
///
/// Светлая и тёмная схемы строятся от одного бренд-акцента [_seed] через
/// [ColorScheme.fromSeed], после чего критичные слоты (accent, surface, текст,
/// error, градации surface) переопределяются вручную «по смыслу» — акцент в
/// тёмной теме осветляется в тот же тон, фон берёт тёмное семейство, текст и
/// фон меняются местами. Семантические токены, которых нет в [ColorScheme]
/// (индикаторы страниц, неактивные иконки, вторичный текст), живут в
/// [AppColors] как [ThemeExtension] и читаются через `context.appColors`.
abstract final class AppTheme {
  const AppTheme._();

  /// Бренд-акцент. Единый seed для обеих схем — hue сохраняется в light и dark.
  static const Color _seed = Color(0xFF6776E0);

  /// Светлая тема.
  static ThemeData get light => _build(Brightness.light);

  /// Тёмная тема.
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = _colorScheme(brightness);
    final appColors = isDark ? const AppColors.dark() : const AppColors.light();
    final textTheme = _textTheme(scheme, appColors);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      extensions: [appColors],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
        // Статус-бар флипается вместе с темой: на светлой — тёмные иконки,
        // на тёмной — светлые. Живёт в теме, поэтому реагирует на themeMode.
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: scheme.primary,
        focusColor: scheme.primary,
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: scheme.primary),
      // M3 по умолчанию делает FAB скруглённым квадратом; возвращаем круг (как
      // было на M2) и фиксируем акцентные цвета для всех FAB разом.
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: const CircleBorder(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        ),
      ),
    );
  }

  static ColorScheme _colorScheme(Brightness brightness) {
    final base = ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
    if (brightness == Brightness.dark) {
      return base.copyWith(
        primary: const Color(0xFF9DA7F1),
        onPrimary: const Color(0xFF0B1030),
        surface: const Color(0xFF101432),
        onSurface: const Color(0xFFECEDF5),
        surfaceContainerLow: const Color(0xFF1A1E3D),
        surfaceContainerHigh: const Color(0xFF242848),
        error: const Color(0xFFF2B8B5),
      );
    }
    return base.copyWith(
      primary: _seed,
      onPrimary: Colors.white,
      surface: const Color(0xFFF3F4F9),
      onSurface: const Color(0xFF101432),
      surfaceContainerLow: Colors.white,
      surfaceContainerHigh: Colors.white,
      error: Colors.red,
    );
  }

  /// M3 [TextTheme]. Слоты несут явный цвет из схемы/[AppColors], чтобы виджеты
  /// брали `Theme.of(context).textTheme.X` без ручного `.copyWith(color:)`.
  static TextTheme _textTheme(ColorScheme scheme, AppColors appColors) {
    return TextTheme(
      // 20 / w500 / onSurface — бывший StyleRes.title
      titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: scheme.onSurface),
      // 18 / w500 / onSurface — бывший StyleRes.subTitle
      titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: scheme.onSurface),
      // 18 / regular / onSurface — бывший StyleRes.mainContent
      bodyLarge: TextStyle(fontSize: 18.0, color: scheme.onSurface),
      // 14 / w400 / textSecondary — бывший StyleRes.content
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: appColors.textSecondary,
      ),
      // 11 / textSecondary — бывший StyleRes.caption
      bodySmall: TextStyle(fontSize: 11.0, color: appColors.textSecondary),
      // 16 / w500 / onPrimary — бывший StyleRes.button (текст на акцентной кнопке)
      labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: scheme.onPrimary),
    );
  }
}

/// Семантические цветовые токены вне [ColorScheme] Material 3.
///
/// [ColorScheme] покрывает primary/surface/error и т.п., но у приложения есть
/// собственные роли (индикаторы страниц, неактивные иконки, вторичный текст),
/// для которых в схеме нет подходящего слота. Они живут здесь и читаются через
/// [AppColorsX.appColors]. Настоящий [lerp] обеспечивает плавный переход при
/// смене темы.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.indicatorActive,
    required this.indicatorInactive,
    required this.inactiveIcon,
    required this.textSecondary,
  });

  /// Токены светлой темы.
  const AppColors.light()
    : indicatorActive = const Color(0xFF9DA7F1),
      indicatorInactive = const Color(0xFFD6D7E0),
      inactiveIcon = const Color(0xFF9395A7),
      textSecondary = const Color(0xFF9395A7);

  /// Токены тёмной темы (осветлены/инвертированы «по смыслу»).
  const AppColors.dark()
    : indicatorActive = const Color(0xFF9DA7F1),
      indicatorInactive = const Color(0xFF3A3E5C),
      inactiveIcon = const Color(0xFF6E7085),
      textSecondary = const Color(0xFFB7B9C8);

  /// Активный индикатор страниц (пейджинг).
  final Color indicatorActive;

  /// Неактивный индикатор страниц.
  final Color indicatorInactive;

  /// Неактивные иконки.
  final Color inactiveIcon;

  /// Вторичный (body / подписи) текст.
  final Color textSecondary;

  @override
  AppColors copyWith({
    Color? indicatorActive,
    Color? indicatorInactive,
    Color? inactiveIcon,
    Color? textSecondary,
  }) {
    return AppColors(
      indicatorActive: indicatorActive ?? this.indicatorActive,
      indicatorInactive: indicatorInactive ?? this.indicatorInactive,
      inactiveIcon: inactiveIcon ?? this.inactiveIcon,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      indicatorActive: Color.lerp(indicatorActive, other.indicatorActive, t)!,
      indicatorInactive: Color.lerp(indicatorInactive, other.indicatorInactive, t)!,
      inactiveIcon: Color.lerp(inactiveIcon, other.inactiveIcon, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}

/// Эргономичный доступ к [AppColors]: `context.appColors.indicatorActive`.
extension AppColorsX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}

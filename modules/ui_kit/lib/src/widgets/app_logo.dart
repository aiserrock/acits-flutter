import 'package:flutter/material.dart';

/// Логотип, адаптивный к теме.
///
/// В логотипе жёстко зашиты два цвета (тёмно-синий текст `#101432` + акцент
/// `#6776E0`), поэтому одноцветная перекраска через `colorFilter` не подходит —
/// убила бы акцент. Вместо этого держим две версии SVG: обычную и `*_dark`
/// (тёмная часть → светлая), и выбираем по [Brightness]. Сами ассеты приходят
/// от приложения через [light]/[dark] — ui_kit ассетами приложения не владеет.
class AppLogo extends StatelessWidget {
  const AppLogo({required this.light, required this.dark, super.key});

  /// Вариант для светлой темы.
  final Widget light;

  /// Вариант для тёмной темы (`*_dark`).
  final Widget dark;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? dark : light;
  }
}

import 'package:ui_kit/ui_kit.dart' as ui_kit;
import 'package:flutter/material.dart';

import 'package:acits_flutter/gen/assets.gen.dart';

/// Логотип ACITS, адаптивный к теме.
///
/// В логотипе жёстко зашиты два цвета (тёмно-синий текст `#101432` + акцент
/// `#6776E0`), поэтому одноцветная перекраска через `colorFilter` не подходит —
/// убила бы акцент. Вместо этого держим две версии SVG: обычную и `*_dark`
/// (тёмная часть → светлая), и выбираем по [Brightness]. Выбор темы делает
/// [ui_kit.AppLogo]; сами ассеты остаются в приложении.

/// Полный логотип с текстом (для шапки логина).
class AppLogoBar extends StatelessWidget {
  const AppLogoBar({this.width, this.height, super.key});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ui_kit.AppLogo(
      light: Assets.image.logoBar.svg(width: width, height: height),
      dark: Assets.image.logoBarDark.svg(width: width, height: height),
    );
  }
}

/// Компактный логотип-иконка (для leading в AppBar выбора приюта).
class AppLogoLeading extends StatelessWidget {
  const AppLogoLeading({this.width, this.height, super.key});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ui_kit.AppLogo(
      light: Assets.image.logoLeadingBar.svg(width: width, height: height),
      dark: Assets.image.logoLeadingBarDark.svg(width: width, height: height),
    );
  }
}

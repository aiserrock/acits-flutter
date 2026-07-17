import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG-иконки, которые использует UI модуля «Личный кабинет».
///
/// Ассеты физически лежат в бандле приложения (`assets/icon/*.svg`); модуль
/// ссылается на них строковыми путями через [SvgPicture.asset] (как app
/// `Assets.icon.*.svg()` — без указания package, чтобы резолвить из бандла
/// приложения). Визуально идентично исходному.
abstract final class PersonalAssets {
  static Widget visible() => SvgPicture.asset('assets/icon/visible.svg');

  static Widget visibleOff() => SvgPicture.asset('assets/icon/visible_off.svg');
}

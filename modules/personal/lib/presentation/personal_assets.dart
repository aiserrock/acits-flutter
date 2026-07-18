import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

/// SVG-иконки, которые использует UI модуля «Личный кабинет».
///
/// Ассеты живут в дизайн-системе (ui_kit) и резолвятся как
/// `packages/ui_kit/assets/icon/*.svg` через package-scoped [Assets].
/// Визуально идентично исходному.
abstract final class PersonalAssets {
  static Widget visible() => Assets.icon.visible.svg();

  static Widget visibleOff() => Assets.icon.visibleOff.svg();
}

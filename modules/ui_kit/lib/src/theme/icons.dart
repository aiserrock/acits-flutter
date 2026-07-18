import 'package:flutter/widgets.dart';

/// Иконочный шрифт icomoon. Шрифт ships внутри пакета, поэтому [_package]
/// заставляет Flutter резолвить семейство из ассетов acits_ui_kit.
class IconRes {
  IconRes._();

  static const String _fontFamily = 'icomoon';
  static const String _package = 'acits_ui_kit';

  static const IconData animalFace = IconData(0xe900, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData applicant = IconData(0xe901, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData curator = IconData(0xe902, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData prescription = IconData(0xe903, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData calendar = IconData(0xe904, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData close = IconData(0xe905, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData comment = IconData(0xe906, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData drugs = IconData(0xe907, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData paw = IconData(0xe908, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData today = IconData(0xe909, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData visibleOff = IconData(0xe90a, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData visible = IconData(0xe90b, fontFamily: _fontFamily, fontPackage: _package);
}

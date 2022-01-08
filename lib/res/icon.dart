// Place fonts/icomoon.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: icomoon
//      fonts:
//       - asset: fonts/icomoon.ttf
import 'package:flutter/widgets.dart';

class IconRes {
  IconRes._();

  static const String _fontFamily = 'icomoon';

  static const IconData animalFace = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData applicant = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData curator = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData prescription = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData calendar = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData close = IconData(0xe905, fontFamily: _fontFamily);
  static const IconData comment = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData drugs = IconData(0xe907, fontFamily: _fontFamily);
  static const IconData paw = IconData(0xe908, fontFamily: _fontFamily);
  static const IconData today = IconData(0xe909, fontFamily: _fontFamily);
  static const IconData visibleOff = IconData(0xe90a, fontFamily: _fontFamily);
  static const IconData visible = IconData(0xe90b, fontFamily: _fontFamily);
}

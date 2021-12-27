import 'package:acits_flutter/res/color.dart';
import 'package:flutter/material.dart';

class StyleRes {
  static const title = TextStyle(
        fontSize: 20.0,
        color: ColorRes.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      content = TextStyle(
        fontSize: 14.0,
        color: ColorRes.textSecondary,
        fontWeight: FontWeight.w400,
      ),
      caption = TextStyle(
        fontSize: 11.0,
        color: ColorRes.textSecondary,
      ),
      error = TextStyle(
        fontSize: 16.0,
        color: Colors.red,
        fontWeight: FontWeight.w500,
      ),
      button = TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );
}

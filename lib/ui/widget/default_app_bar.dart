import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

/// Дефолтный AppBar
class DefaultAppBar extends AppBar {
  DefaultAppBar({
    super.key,
    required this.titleString,
    required VoidCallback onBackPressure,
    super.elevation,
  }) : super(
         title: Text(titleString, style: const TextStyle(color: ColorRes.textPrimary)),
         leading: GestureDetector(
           onTap: onBackPressure,
           child: const Icon(Icons.arrow_back_ios, color: ColorRes.accent),
         ),
         centerTitle: true,
         backgroundColor: ColorRes.foreground,
         shadowColor: Colors.transparent,
       );

  final String titleString;
}

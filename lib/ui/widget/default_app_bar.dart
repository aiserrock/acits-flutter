import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

/// Дефолтный AppBar
class DefaultAppBar extends AppBar {
  DefaultAppBar({
    Key? key,
    required this.titleString,
    required VoidCallback onBackPressure,
    double? elevation,
  }) : super(
          key: key,
          title: Text(
            titleString,
            style: const TextStyle(color: ColorRes.textPrimary),
          ),
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorRes.accent,
            ),
            onTap: onBackPressure,
          ),
          centerTitle: true,
          backgroundColor: ColorRes.foreground,
          shadowColor: Colors.transparent,
          elevation: elevation,
        );

  final String titleString;
}

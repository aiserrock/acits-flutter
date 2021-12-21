// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Цвета используемые в приложении
@singleton
class ColorRes {
  /// Важная кнопка
  static const Color primaryButton = _blue400,

      /// Активный индикатор (страниц при пейджинге)
      indicatorActive = _blue200,

      /// Неактивный индикатор (страниц при пейджинге)
      indicatorInactive = _grey100,

      /// Акцент
      accent = _blue400,

      /// Важный (title) текст
      textPrimary = _black100,

      /// Контент (body / message) текст
      textSecondary = _grey200;
}

/// Базовые цвета из UI Kit
const Color _grey200 = Color(0xFF9395A7),
    _grey100 = Color(0xFFD6D7E0),
    _grey0 = Color(0xFFF3F4F9),
    _blue400 = Color(0xFF6776E0),
    _black100 = Color(0xFF101432),
    _blue200 = Color(0xFF9DA7F1);

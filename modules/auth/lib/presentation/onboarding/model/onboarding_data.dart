import 'package:flutter/widgets.dart';

/// Одна страница онбординга: иллюстрация + заголовок + текст.
///
/// [image] — готовый виджет иллюстрации (app-ассет прокидывается корнем; модуль
/// не владеет ассетами приложения). Виджет строится с `fit: BoxFit.fitWidth`
/// на стороне приложения.
class OnboardingData {
  final Widget image;
  final String title;
  final String message;

  OnboardingData({required this.image, required this.title, required this.message});
}

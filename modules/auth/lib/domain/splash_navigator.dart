import 'package:acits_domain/acits_domain.dart';

/// Навигация splash-роута: переходы + снятие нативного/DOM splash после
/// отрисовки целевого экрана. Реализация живёт в приложении (знает go_router и
/// платформенный `removeSplash`); модуль дёргает её из решения о старте.
///
/// Каждый метод сам снимает splash после ухода на целевой экран (post-frame),
/// поэтому переход между splash-кадром и экраном остаётся бесшовным.
abstract interface class SplashNavigator {
  /// Уйти на онбординг (первый запуск) и снять splash.
  void toOnboardingAndReveal();

  /// Уйти на экран входа и снять splash.
  void toLoginAndReveal();

  /// Уйти на корневой экран и снять splash.
  void toRootAndReveal();

  /// Уйти на экран входа и открыть выбор приюта поверх, затем снять splash.
  void toPickShelterAndReveal({required List<Shelter> shelterList, required bool autoSelectSingle});
}

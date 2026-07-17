import 'package:acits_domain/acits_domain.dart';

/// Навигационный контракт фичи «Авторизация». Реализация (знающая go_router-пути
/// приложения) живёт в корневом навигационном слое и инъектится в модуль — так
/// модуль не зависит ни от go_router, ни от роутов приложения.
abstract interface class AuthRouterService implements RouterService {
  /// Перейти на корневой экран приложения (после успешного выбора приюта).
  void toRoot();

  /// Перейти на экран входа (после онбординга / инвалидации сессии).
  void toLogin();

  /// Открыть экран регистрации.
  void toRegistration();

  /// Открыть экран выбора приюта: [shelterList] — доступные приюты,
  /// [autoSelectSingle] — автоприменить единственный приют без экрана.
  void toPickShelter({required List<Shelter> shelterList, required bool autoSelectSingle});

  /// Открыть экран выбора приюта (generic-поиск) и вернуть выбранный приют.
  Future<Shelter?> pickShelterFromSearch();
}

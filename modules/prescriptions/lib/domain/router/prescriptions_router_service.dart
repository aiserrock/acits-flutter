import 'package:core/domain.dart';

import 'package:prescriptions/domain/domain.dart';

/// Навигационный контракт фичи «Назначения». Реализация (знающая go_router-пути
/// приложения) живёт в корневом навигационном слое и инъектится в модуль — так
/// модуль не зависит ни от go_router, ни от роутов приложения.
///
/// Экран редактора назначения открывает generic-поиск приложения для выбора
/// животного и препарата; результат возвращается сущностями модуля/домена.
abstract interface class PrescriptionsRouterService implements RouterService {
  /// Открыть поиск животного; вернуть выбранную ссылку (или null, если отмена).
  Future<PrescriptionAnimalRef?> pickAnimal();

  /// Открыть поиск препарата; вернуть выбранный [Drug] (или null, если отмена).
  Future<Drug?> pickDrug();
}

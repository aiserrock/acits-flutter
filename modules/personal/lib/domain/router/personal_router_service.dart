import 'package:acits_domain/acits_domain.dart';

import '../animal_note.dart';

/// Навигационный контракт фичи «Личный кабинет / комментарии». Реализация
/// (знающая go_router-пути приложения) живёт в корневом навигационном слое и
/// инъектится в модуль — так модуль не зависит ни от go_router, ни от роутов
/// приложения.
abstract interface class PersonalRouterService implements RouterService {
  /// Открыть экран добавления/редактирования комментария к животному
  /// [animalId]. При редактировании передаётся [comment]. Возвращает
  /// созданный/обновлённый [AnimalNote] (или null, если отменено).
  Future<AnimalNote?> openCommentEdit(int animalId, {AnimalNote? comment});
}

import 'package:core/domain.dart';

/// Навигационный контракт фичи «Животные». Реализация (знающая go_router-пути
/// приложения) живёт в корневом навигационном слое и инъектится в модуль — так
/// модуль не зависит ни от go_router, ни от роутов приложения.
abstract interface class AnimalsRouterService implements RouterService {
  /// Открыть детальный экран животного [id].
  void openDetail(int id);

  /// Открыть экран создания животного. Возвращает `true`, если животное было
  /// добавлено (список нужно перезагрузить).
  Future<bool?> openCreate();

  /// Открыть экран редактирования животного [id].
  void openEdit(int id);

  /// Открыть просмотрщик PDF-карточки животного [id].
  void openAnimalPdf(int id);
}

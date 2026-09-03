import 'package:util/util.dart';

import 'package:prescriptions/domain/domain.dart';

/// Контракт репозитория назначений и препаратов — feature-local.
///
/// Назначения ([Prescription]), лента исполнений «на сегодня»
/// ([PrescriptionExecutionToday]) и каталог препаратов ([Drug]) живут в одном
/// контракте намеренно: за ними стоит один `PrescriptionApiPort` и один скоуп
/// текущего приюта. Всё в доменных типах и [Result]<[Failure], T> — DTO сюда
/// не проникают (остаются в data-слое).
abstract interface class PrescriptionRepository {
  /// Исполнения назначений, запланированные на сегодня (лента главного экрана).
  Future<Result<Failure, List<PrescriptionExecutionToday>>> listTodayExecutions({String? search, String? ordering});

  /// Назначения животного [animalId]: актуальные ([isActual]) или прошлые
  /// ([isOld]).
  Future<Result<Failure, List<Prescription>>> listByAnimal(
    int animalId, {
    int? limit,
    int offset,
    bool isActual,
    bool isOld,
  });

  Future<Result<Failure, Prescription>> getById(int id);

  /// Создаёт назначение из [prescription]; возвращает созданное.
  Future<Result<Failure, Prescription>> create(Prescription prescription);

  /// Обновляет назначение (id берётся из [prescription]); возвращает сохранённое.
  Future<Result<Failure, Prescription>> update(Prescription prescription);

  /// Каталог препаратов приюта, отфильтрованный по [searchRequest].
  Future<Result<Failure, List<Drug>>> listDrugs({String? searchRequest, int limit, int offset});
}

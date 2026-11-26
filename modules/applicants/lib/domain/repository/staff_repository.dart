import 'package:core/domain.dart';

/// Контракт репозитория сотрудников — заявители ([Applicant]) и кураторы
/// ([Curator]) — feature-local.
///
/// Обе сущности живут в одном контракте намеренно: за ними стоит один
/// `StaffApiPort` и один скоуп текущего приюта. Всё в доменных типах и
/// [Result]<[Failure], T> — DTO сюда не проникают (остаются в data-слое).
abstract interface class StaffRepository {
  /// Список кураторов приюта, отфильтрованный по [searchRequest].
  Future<Result<Failure, List<Curator>>> listCurators({int limit, int offset, String? searchRequest});

  Future<Result<Failure, Curator>> getCuratorById(int id);

  /// Обновляет куратора [id] значениями [curator]; возвращает сохранённого.
  Future<Result<Failure, Curator>> updateCurator(int id, Curator curator);

  /// Создаёт куратора из [curator]; возвращает созданного.
  Future<Result<Failure, Curator>> createCurator(Curator curator);

  /// Список заявителей приюта, отфильтрованный по [searchRequest].
  Future<Result<Failure, List<Applicant>>> listApplicants({int limit, int offset, String? searchRequest});

  Future<Result<Failure, Applicant>> getApplicantById(int id);

  /// Обновляет заявителя [id] значениями [applicant]; возвращает сохранённого.
  Future<Result<Failure, Applicant>> updateApplicant(int id, Applicant applicant);

  /// Создаёт заявителя из [applicant]; возвращает созданного.
  Future<Result<Failure, Applicant>> createApplicant(Applicant applicant);
}

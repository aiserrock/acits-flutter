import 'package:util/util.dart';

import 'package:personal/domain/domain.dart';

/// Контракт репозитория профиля текущего пользователя (feature-local).
///
/// Всё в доменных типах и [Result]<[Failure], T> — DTO сюда не проникают
/// (остаются в data-слое). Скоуп по приюту и сброс кеша при разлогине —
/// внутренняя забота реализации (через [PersonalShelterProvider]).
abstract interface class PersonalRepository {
  /// Профиль текущего пользователя. При [force] игнорирует кеш и идёт в сеть.
  Future<Result<Failure, UserProfile>> fetchPersonal({bool force = false});

  /// Сохраняет изменённый профиль [data]; возвращает актуальную версию.
  Future<Result<Failure, UserProfile>> changePersonal(UserProfile data);

  /// Меняет пароль пользователя.
  Future<Result<Failure, void>> changePass(String oldPass, String newPass);
}

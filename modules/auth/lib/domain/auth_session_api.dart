import 'package:acits_domain/acits_domain.dart';

import 'package:auth/domain/domain.dart';

/// Сессионный фасад авторизации для экранов модуля.
///
/// Реальный держатель сессии ([AuthService]) — кросс-каттинг инфра приложения:
/// его импортят все фичи (токены, текущий приют, роль). Он НЕ может жить в
/// модуле auth, иначе каждая фича зависела бы от модуля. Поэтому модуль
/// объявляет узкий контракт, а приложение реализует его своим `AuthService`
/// (`implements AuthSessionApi`) и инъектит в cubit'ы экранов. Так экраны видят
/// ровно то, что им нужно, без зависимости на приложение.
///
/// Возвраты login/setCurrentShelter экранам не нужны — контракт объявляет их
/// `Future<void>` (реализация может возвращать конкретный DTO: любой тип —
/// подтип `void`).
abstract interface class AuthSessionApi {
  /// Текущий список приютов пользователя (кэш последнего запроса).
  List<Shelter> get shelterList;

  /// Войти по логину/паролю. Бросает доменное исключение при ошибке.
  Future<void> login(String? login, String? pass);

  /// Попробовать восстановить сессию из прошлого refresh-токена.
  Future<bool> tryRefreshLastAuth();

  /// Восстановить ранее выбранный приют из хранилища (для автовхода).
  Future<bool> restoreShelter();

  /// Загрузить список приютов пользователя.
  Future<List<Shelter>> getShelterList();

  /// Установить текущий приют по [shelterId].
  Future<void> setCurrentShelter(int shelterId);

  /// Зарегистрировать нового администратора приюта.
  Future<bool> registrationAdmin(AdminRegistrationInput input);

  /// Зарегистрировать нового кастомера (сотрудник/гость).
  Future<bool> registrationCustomer(WorkerRegistrationInput input);

  /// Подтвердить электронную почту по ссылке [confirmLink].
  Future<void> confirmEmail(String confirmLink);
}

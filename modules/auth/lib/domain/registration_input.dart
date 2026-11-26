/// Роль кастомера при регистрации (доменный ввод, не завязан на API-enum).
enum WorkerRole { guest, worker }

/// Ввод формы регистрации администратора приюта.
///
/// Собирается экраном регистрации из полей формы; [AuthSessionApi] превращает
/// его в write-DTO порта. Экран не знает про сгенерированные API-типы.
class AdminRegistrationInput {
  const AdminRegistrationInput({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.shelterName,
    required this.country,
    required this.city,
    this.fathersName,
    this.phoneNumber,
    this.region,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? fathersName;
  final String? phoneNumber;

  final String shelterName;
  final String country;
  final String city;
  final String? region;
}

/// Ввод формы регистрации кастомера (сотрудник/гость приюта).
class WorkerRegistrationInput {
  const WorkerRegistrationInput({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.shelterId,
    this.fathersName,
    this.phoneNumber,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? fathersName;
  final String? phoneNumber;

  /// Id выбранного приюта (null, если не выбран).
  final int? shelterId;
  final WorkerRole role;
}

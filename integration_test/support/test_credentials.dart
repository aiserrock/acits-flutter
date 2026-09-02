/// Учётные данные тестового аккаунта для e2e-прогонов.
///
/// Реальный dev-аккаунт `test_user_2` / `user10000` (user id=3) валиден на всех
/// dev-серверах и имеет приют 50 «Пушистые попки» — показательный демо-приют.
/// Не хардкодим в сценарии: значения приходят через `--dart-define`, а дефолт
/// позволяет гонять локально без флагов.
///
/// Переопределение:
/// `patrol test --flavor dev \
///    --dart-define=ACITS_TEST_LOGIN=... --dart-define=ACITS_TEST_PASSWORD=...`
class TestCredentials {
  const TestCredentials({required this.login, required this.password, required this.shelterName});

  factory TestCredentials.fromEnv() => const TestCredentials(
    login: String.fromEnvironment('ACITS_TEST_LOGIN', defaultValue: 'test_user_2'),
    password: String.fromEnvironment('ACITS_TEST_PASSWORD', defaultValue: 'user10000'),
    shelterName: String.fromEnvironment('ACITS_TEST_SHELTER', defaultValue: 'Пушистые попки'),
  );

  final String login;
  final String password;

  /// Имя приюта на экране выбора (pick-shelter рисует `Text(shelter.name)`).
  final String shelterName;
}

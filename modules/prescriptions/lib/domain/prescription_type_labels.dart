/// Порт человекочитаемых имён типов назначений (из серверного конфига).
///
/// [PrescriptionService] и UI-табы показывают имя типа по его wire-значению
/// (`my_type`), но модуль не знает про `ConfigService` приложения — корень
/// мостит этот порт к `ConfigService` (`getMyTypeName` + прогрев `typeValues`).
///
/// [ensureLoaded] прогревает серверный конфиг, если он ещё не загружен (сервис
/// вызывает его перед выборками, как раньше делал `ConfigService.getTypeValues`).
abstract interface class PrescriptionTypeLabels {
  /// Человекочитаемое имя типа назначения по wire-строке (`my_type`), либо null.
  String? nameForWire(String? wire);

  /// Прогреть серверный конфиг типов, если он ещё не загружен.
  Future<void> ensureLoaded();
}

sealed class Failure {
  const Failure();

  /// Приводит пойманный объект к [Failure]: уже типизированная ошибка проходит
  /// как есть, всё остальное — [UnknownFailure]. Транспортные исключения сюда
  /// доходить не должны — их маппит data-слой (`guard`).
  static Failure from(Object error) => error is Failure ? error : const UnknownFailure();
}

sealed class NetworkFailure extends Failure {
  const NetworkFailure();
}

final class NoInternet extends NetworkFailure {
  const NoInternet();
}

final class Timeout extends NetworkFailure {
  const Timeout();
}

final class ServerFailure extends NetworkFailure {
  const ServerFailure(this.code, [this.note]);

  final int code;
  final String? note;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ServerFailure && other.code == code && other.note == note;

  @override
  int get hashCode => Object.hash(code, note);
}

/// Сессия недействительна (401) — вход заново её восстановит.
final class AuthFailure extends Failure {
  const AuthFailure();
}

/// Доступ запрещён (403): сессия валидна, но прав на операцию нет. Отличается
/// от [AuthFailure] тем, что перелогин не поможет — предлагать его вредно.
final class ForbiddenFailure extends Failure {
  const ForbiddenFailure();
}

final class ParseFailure extends Failure {
  const ParseFailure();
}

final class UnknownFailure extends Failure {
  const UnknownFailure();
}

/// Ссылка подтверждения e-mail отклонена: недоверенный адрес или сервер ответил,
/// что ссылка недействительна.
final class EmailLinkRejected extends Failure {
  const EmailLinkRejected();
}

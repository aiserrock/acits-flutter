sealed class Failure {
  const Failure();
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

final class AuthFailure extends Failure {
  const AuthFailure();
}

final class ParseFailure extends Failure {
  const ParseFailure();
}

final class UnknownFailure extends Failure {
  const UnknownFailure();
}

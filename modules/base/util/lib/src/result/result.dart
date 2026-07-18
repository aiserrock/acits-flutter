/// Функциональный результат операции: [Ok] с значением или [Err] с ошибкой.
sealed class Result<F, T> {
  const Result();

  const factory Result.ok(T value) = Ok<F, T>;
  const factory Result.err(F failure) = Err<F, T>;

  bool get isOk => this is Ok<F, T>;
  bool get isErr => this is Err<F, T>;

  T? get valueOrNull => switch (this) {
    Ok(:final value) => value,
    Err() => null,
  };

  F? get failureOrNull => switch (this) {
    Ok() => null,
    Err(:final failure) => failure,
  };

  R fold<R>(R Function(F failure) onErr, R Function(T value) onOk) => switch (this) {
    Ok(:final value) => onOk(value),
    Err(:final failure) => onErr(failure),
  };

  Result<F, R> map<R>(R Function(T value) transform) => switch (this) {
    Ok(:final value) => Ok(transform(value)),
    Err(:final failure) => Err(failure),
  };

  Result<R, T> mapErr<R>(R Function(F failure) transform) => switch (this) {
    Ok(:final value) => Ok(value),
    Err(:final failure) => Err(transform(failure)),
  };
}

final class Ok<F, T> extends Result<F, T> {
  const Ok(this.value);

  final T value;
}

final class Err<F, T> extends Result<F, T> {
  const Err(this.failure);

  final F failure;
}

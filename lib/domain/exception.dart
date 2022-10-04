class NotAuthorizedException implements Exception {
  NotAuthorizedException({this.message});

  final String? message;

  @override
  String toString() {
    return message ?? super.toString();
  }
}

class MessagedException implements Exception {
  MessagedException({
    this.message,
    this.error,
  });

  final String? message;
  final Object? error;

  @override
  String toString() {
    return message ?? super.toString();
  }
}

class EmailConfirmException implements Exception {
  EmailConfirmException({
    this.message,
    this.error,
  });

  final String? message;
  final Object? error;

  @override
  String toString() {
    return message ?? super.toString();
  }
}

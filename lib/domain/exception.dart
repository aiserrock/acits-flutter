class NotAuthorizedException implements Exception {
  NotAuthorizedException({this.message});

  final String? message;

  @override
  String toString() {
    return message ?? super.toString();
  }
}

class MesssagedException implements Exception {
  MesssagedException({
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

import 'package:flutter_test/flutter_test.dart';
import 'package:observability/observability.dart';

final class _Recording implements ErrorReporter {
  final errors = <(Object, String?, bool)>[];
  final crumbs = <String>[];
  final users = <(String?, String?)>[];
  final collection = <bool>[];

  @override
  Future<void> recordError(Object error, StackTrace? stackTrace, {String? reason, bool fatal = false}) async =>
      errors.add((error, reason, fatal));

  @override
  void breadcrumb(String message) => crumbs.add(message);

  @override
  Future<void> setUser({String? userId, String? shelterId}) async => users.add((userId, shelterId));

  @override
  Future<void> setCollectionEnabled(bool enabled) async => collection.add(enabled);
}

final class _Broken implements ErrorReporter {
  @override
  Future<void> recordError(Object error, StackTrace? stackTrace, {String? reason, bool fatal = false}) =>
      throw StateError('backend down');

  @override
  void breadcrumb(String message) => throw StateError('backend down');

  @override
  Future<void> setUser({String? userId, String? shelterId}) => throw StateError('backend down');

  @override
  Future<void> setCollectionEnabled(bool enabled) => throw StateError('backend down');
}

void main() {
  test('every call reaches each backend exactly once', () async {
    final a = _Recording();
    final b = _Recording();
    final reporter = CompositeErrorReporter([a, b]);
    final error = StateError('boom');

    await reporter.recordError(error, StackTrace.current, reason: 'load failed', fatal: true);
    reporter.breadcrumb('opened animal 5');
    await reporter.setUser(userId: '7', shelterId: '50');
    await reporter.setCollectionEnabled(false);

    for (final backend in [a, b]) {
      expect(backend.errors, [(error, 'load failed', true)]);
      expect(backend.crumbs, ['opened animal 5']);
      expect(backend.users, [('7', '50')]);
      expect(backend.collection, [false]);
    }
  });

  test('a backend that throws does not stop the others and does not surface', () async {
    final healthy = _Recording();
    final reporter = CompositeErrorReporter([_Broken(), healthy]);

    await reporter.recordError(StateError('boom'), null);
    reporter.breadcrumb('crumb');
    await reporter.setUser(userId: '7');
    await reporter.setCollectionEnabled(true);

    expect(healthy.errors, hasLength(1));
    expect(healthy.crumbs, ['crumb']);
    expect(healthy.users, [('7', null)]);
    expect(healthy.collection, [true]);
  });
}

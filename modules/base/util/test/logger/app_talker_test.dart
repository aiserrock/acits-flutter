import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:util/util.dart';

void main() {
  late List<(Object, String)> errors;
  late List<String> crumbs;

  setUp(() {
    errors = [];
    crumbs = [];
  });

  Talker build({required bool printToConsole}) => createAppTalker(
    printToConsole: printToConsole,
    onError: (error, _, message) => errors.add((error, message)),
    onBreadcrumb: crumbs.add,
  );

  // The release configuration: nothing is printed, everything is still reported.
  group('with console output off (prod release)', () {
    test('an error log reaches the reporter with its exception', () {
      final failure = StateError('boom');
      build(printToConsole: false).error('Load failed', failure, StackTrace.current);
      expect(errors, [(failure, 'Load failed')]);
    });

    test('a handled exception reaches the reporter', () {
      final failure = Exception('handled');
      build(printToConsole: false).handle(failure, StackTrace.current, 'while saving');
      expect(errors.single.$1, failure);
    });

    test('an error log without an exception is reported with its message', () {
      build(printToConsole: false).error('Token refresh failed');
      expect(errors, [('Token refresh failed', 'Token refresh failed')]);
    });

    test('info and warning logs become breadcrumbs, debug logs stay local', () {
      build(printToConsole: false)
        ..info('Login success')
        ..warning('Slow response')
        ..debug('raw payload');
      expect(crumbs, ['Login success', 'Slow response']);
      expect(errors, isEmpty);
    });

    test('keeps no log history on the device', () {
      final talker = build(printToConsole: false)..info('Login success');
      expect(talker.history, isEmpty);
    });
  });

  test('with console output on (dev) the same records are reported and history is kept', () {
    final talker = build(printToConsole: true)
      ..info('Login success')
      ..error('Load failed');
    expect(crumbs, ['Login success']);
    expect(errors, hasLength(1));
    expect(talker.history, hasLength(2));
  });
}

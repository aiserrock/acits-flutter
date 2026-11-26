import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:util/util.dart';

void main() {
  late Talker talker;

  setUp(() {
    talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
    GetIt.instance.registerSingleton<Talker>(talker);
  });

  tearDown(() => GetIt.instance.reset());

  group('Log with a registered Talker', () {
    test('debug goes to the debug level', () {
      Log.debug('d');

      expect(talker.history.single.logLevel, LogLevel.debug);
      expect(talker.history.single.message, 'd');
    });

    test('info goes to the info level', () {
      Log.info('i');

      expect(talker.history.single.logLevel, LogLevel.info);
      expect(talker.history.single.message, 'i');
    });

    test('warning goes to the warning level', () {
      Log.warning('w');

      expect(talker.history.single.logLevel, LogLevel.warning);
      expect(talker.history.single.message, 'w');
    });

    test('error goes to the error level with exception and stack trace', () {
      final failure = StateError('boom');
      final stack = StackTrace.current;

      Log.error('e', failure, stack);

      final entry = talker.history.single;
      expect(entry.logLevel, LogLevel.error);
      expect(entry.message, 'e');
      expect(entry.exception, failure);
      expect(entry.stackTrace, stack);
    });

    test('handle records the exception at the error level', () {
      final failure = Exception('handled');

      Log.handle(failure, StackTrace.current, 'while saving');

      final entry = talker.history.single;
      expect(entry.logLevel, LogLevel.error);
      expect(entry.exception, failure);
    });
  });

  group('Log without a registered Talker', () {
    setUp(() => GetIt.instance.reset());

    test('every method is a silent no-op', () {
      expect(() {
        Log.debug('d');
        Log.info('i');
        Log.warning('w', Exception('x'));
        Log.error('e', Exception('x'), StackTrace.current);
        Log.handle(Exception('x'));
      }, returnsNormally);
      expect(talker.history, isEmpty);
    });
  });
}

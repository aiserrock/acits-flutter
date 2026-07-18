import 'package:util/util.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingTask extends AppTask {
  _RecordingTask(this.name, this.log);

  @override
  final String name;
  final List<String> log;

  @override
  Future<void> run() async {
    log.add(name);
  }
}

class _ThrowingTask extends AppTask {
  _ThrowingTask(this.name, this.log);

  @override
  final String name;
  final List<String> log;

  @override
  Future<void> run() async {
    log.add(name);
    throw StateError('boom in $name');
  }
}

void main() {
  group('AppTaskRunner', () {
    test('runs tasks in order', () async {
      final log = <String>[];
      final runner = AppTaskRunner([_RecordingTask('a', log), _RecordingTask('b', log), _RecordingTask('c', log)]);

      await runner.run();

      expect(log, ['a', 'b', 'c']);
    });

    test('propagates exception and stops the pipeline', () async {
      final log = <String>[];
      final runner = AppTaskRunner([_RecordingTask('a', log), _ThrowingTask('b', log), _RecordingTask('c', log)]);

      await expectLater(runner.run(), throwsA(isA<StateError>()));
      // 'c' не должна выполниться — падение останавливает пайплайн.
      expect(log, ['a', 'b']);
    });
  });
}

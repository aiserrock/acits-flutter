/// Единица стартовой инициализации. [name] — для логов/тестов.
abstract class AppTask {
  Future<void> run();
  String get name;
}

/// Выполняет задачи строго по порядку, дожидаясь каждую. Исключения не
/// глотаются — падение задачи пробрасывается наверх и останавливает пайплайн.
class AppTaskRunner {
  const AppTaskRunner(this.tasks);

  final List<AppTask> tasks;

  Future<void> run() async {
    for (final task in tasks) {
      await task.run();
    }
  }
}

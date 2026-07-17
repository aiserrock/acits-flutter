import 'package:auth/auth.dart' show AuthDebugHook;
import 'package:injectable/injectable.dart';

@singleton
@prod
/// Сервис отладки приложения
class DebugService implements AuthDebugHook {
  /// открыть экран отладки
  @override
  void openDebugScreen() {
    /// Попытка входа в дебаг экран на проде
  }
}

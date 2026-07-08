import 'package:flutter_bloc/flutter_bloc.dart';

/// Безопасный `emit` для Cubit'ов.
///
/// Асинхронные методы часто вызывают `emit` после `await`. Если экран закрыли
/// (и BlocProvider вызвал `close()`) во время ожидания, обычный `emit` бросает
/// `StateError`. [safeEmit] молча пропускает эмиссию для уже закрытого cubit'а.
extension SafeEmit<S> on Cubit<S> {
  void safeEmit(S state) {
    if (isClosed) return;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    emit(state);
  }
}

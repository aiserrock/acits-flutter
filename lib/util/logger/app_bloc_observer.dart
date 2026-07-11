import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// [Bloc.observer] на базе Talker: автоматически логирует события, переходы и
/// ошибки всех cubit'ов/bloc'ов в общий [Talker] (виден в `TalkerScreen`).
///
/// Полные данные state не печатаем (`printStateFullData: false`) — состояния
/// крупные (списки животных и т.п.), в логах достаточно типа перехода.
TalkerBlocObserver createAppBlocObserver(Talker talker) {
  return TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(printStateFullData: false, printEventFullData: false),
  );
}

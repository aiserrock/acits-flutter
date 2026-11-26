import 'package:util/util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:di/di.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/observability_setup.dart';

/// Стартовый пайплайн приложения как упорядоченный список [AppTask]
/// (base). Обёртка над теми же фазами инициализации, что раньше жили
/// прямо в `main()` — поведение и порядок сохранены 1:1.
///
/// Порядок:
///   1. [FirebaseInitTask]        — Firebase (первым; сбой не останавливает запуск).
///   2. [IndependentInitTask]     — локализация / ориентация / версия одним
///      `Future.wait` (как раньше — параллельно, чтобы не тормозить холодный
///      старт web).
///   3. [SentryInitTask]          — Sentry, если DSN задан при сборке.
///   4. [DiInitTask]              — get_it (часть сервисов опирается на п.2).
///   5. [BlocObserverTask]        — Bloc.observer поверх готового DI.
///
/// `WidgetsFlutterBinding.ensureInitialized`, `FlutterNativeSplash.preserve` и
/// `usePathUrlStrategy` остаются инлайн в `main()` — они трогают binding до
/// задач и логически предшествуют пайплайну.
List<AppTask> appStartupTasks({required FirebaseOptions firebaseOptions, required ObservabilitySetup observability}) =>
    [
      FirebaseInitTask(firebaseOptions, observability),
      const IndependentInitTask(),
      SentryInitTask(observability),
      DiInitTask(observability),
      const BlocObserverTask(),
    ];

/// Firebase проекта флейвора. Сбой инициализации не останавливает запуск:
/// приложение обязано открыться и без Firebase.
class FirebaseInitTask implements AppTask {
  const FirebaseInitTask(this._options, this._observability);

  final FirebaseOptions _options;
  final ObservabilitySetup _observability;

  @override
  String get name => 'firebase';

  @override
  Future<void> run() => _observability.initFirebase(_options);
}

/// Sentry — только если DSN задан при сборке. Идёт после [IndependentInitTask]:
/// release и dist берутся из уже загруженной версии приложения.
class SentryInitTask implements AppTask {
  const SentryInitTask(this._observability);

  final ObservabilitySetup _observability;

  @override
  String get name => 'sentry';

  @override
  Future<void> run() => _observability.initSentry();
}

/// Независимые инициализации — параллельно (ускоряет старт, особенно «белый
/// экран» на web): локализация, ориентация и версия приложения не зависят друг
/// от друга. Один `Future.wait` сохраняет ту же параллельность, что была в
/// прежнем `main()`.
class IndependentInitTask implements AppTask {
  const IndependentInitTask();

  @override
  String get name => 'independent-init';

  @override
  Future<void> run() async {
    await Future.wait([
      EasyLocalization.ensureInitialized(),
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
      AppVersion.load(),
    ]);
  }
}

/// get_it. Идёт после [IndependentInitTask] — часть сервисов может опираться на
/// уже готовые локализацию/версию.
class DiInitTask implements AppTask {
  const DiInitTask(this._observability);

  final ObservabilitySetup _observability;

  @override
  String get name => 'di';

  @override
  Future<void> run() => initDi(_observability);
}

/// Логи всех cubit'ов/bloc'ов идут в общий Talker.
/// Требует готового DI ([DiInitTask]), поэтому — последним.
class BlocObserverTask implements AppTask {
  const BlocObserverTask();

  @override
  String get name => 'bloc-observer';

  @override
  Future<void> run() async {
    Bloc.observer = createAppBlocObserver(getIt<Talker>());
  }
}

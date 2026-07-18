import 'package:util/util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/util/logger/app_bloc_observer.dart';
import 'package:di/di.dart';

/// Стартовый пайплайн приложения как упорядоченный список [AppTask]
/// (base). Обёртка над теми же фазами инициализации, что раньше жили
/// прямо в `main()` — поведение и порядок сохранены 1:1.
///
/// Порядок:
///   1. [FirebaseInitTask]        — Firebase + crashlytics-обработчики (первым).
///   2. [IndependentInitTask]     — локализация / ориентация / версия одним
///      `Future.wait` (как раньше — параллельно, чтобы не тормозить холодный
///      старт web).
///   3. [DiInitTask]              — get_it (часть сервисов опирается на п.2).
///   4. [BlocObserverTask]        — Bloc.observer поверх готового DI.
///
/// `WidgetsFlutterBinding.ensureInitialized`, `FlutterNativeSplash.preserve` и
/// `usePathUrlStrategy` остаются инлайн в `main()` — они трогают binding до
/// задач и логически предшествуют пайплайну.
List<AppTask> appStartupTasks({required FirebaseOptions firebaseOptions}) => [
  FirebaseInitTask(firebaseOptions),
  const IndependentInitTask(),
  const DiInitTask(),
  const BlocObserverTask(),
];

/// prod-окружение: Firebase-проект acits-prod. Crashlytics существует только на
/// мобильных — на web плагина нет, обработчики под `!kIsWeb`.
class FirebaseInitTask implements AppTask {
  const FirebaseInitTask(this._options);

  final FirebaseOptions _options;

  @override
  String get name => 'firebase';

  @override
  Future<void> run() async {
    await Firebase.initializeApp(options: _options);
    if (!kIsWeb) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }
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
  const DiInitTask();

  @override
  String get name => 'di';

  @override
  Future<void> run() => initDi();
}

/// Логи всех cubit'ов/bloc'ов идут в общий Talker (в prod-release он выключен).
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

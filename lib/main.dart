import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:util/util.dart';

import 'package:app_services/app_services.dart' show Log;
import 'package:di/di.dart';

import 'package:acits_flutter/bootstrap.dart';
import 'package:acits_flutter/firebase/firebase_config.dart';
import 'package:acits_flutter/run_app.dart';

/// PROD-энтрипоинт. Тонкий: подготовка (bootstrap) и запуск (runApp) вынесены —
/// см. `bootstrap.dart` (подготовительные фазы) и `run_app.dart` (runApp).
Future<void> main() => runAppWith(bootstrap: _bootstrapProd);

/// Подготовительный пайплайн prod-флейвора: Firebase(prod) → локализация/
/// ориентация/версия → DI → Bloc.observer. Порядок и параллелизм — в
/// [appStartupTasks].
Future<void> _bootstrapProd() async {
  await AppTaskRunner(appStartupTasks(firebaseOptions: prodFirebaseOptions)).run();
  Bloc.observer = createAppBlocObserver(getIt<Talker>());
  Log.info('App start · flavor=prod');
}

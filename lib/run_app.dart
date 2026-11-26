import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:di/di.dart';
import 'package:shell/shell.dart' show AppScaffold;

import 'package:acits_flutter/startup_failure_app.dart';

/// Точка запуска приложения (по образцу reference-app `runner.run`).
///
/// Делает ровно три вещи: инициализирует binding + web-специфику (splash,
/// url-strategy), запускает подготовительный пайплайн [bootstrap], затем
/// `runApp` с корневым виджетом [AppScaffold] (живёт в shell). Флейвор-специфику
/// (Firebase-проект, DI, прокси, dev-логи) поставляет вызывающая сторона через
/// [bootstrap] и [overlayBuilder] — сам runApp одинаков для prod/dev.
Future<void> runAppWith({required Future<void> Function() bootstrap, TransitionBuilder? overlayBuilder}) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  // Держим нативный splash (Android/iOS) поверх дерева до тех пор, пока splash-роут
  // не решит маршрут (refresh + приют) и не вызовет remove(). Так авторизованный
  // юзер на холодном старте видит только нативный splash → сразу root, без мелькания
  // login. На web splash держит DOM (#splash в index.html), поэтому там preserve — no-op.
  if (!kIsWeb) FlutterNativeSplash.preserve(widgetsBinding: binding);

  // Обычные web-пути (/login вместо /#/login). No-op на мобильных. Требует
  // SPA-fallback на сервере (nginx try_files; для GitHub Pages — 404.html).
  usePathUrlStrategy();

  await _startOrShowFailure(bootstrap: bootstrap, overlayBuilder: overlayBuilder);
}

/// Runs [bootstrap] and starts the app. When the pipeline throws (DI,
/// localization or storage failed), shows [StartupFailureApp] instead of
/// leaving the native splash on screen, and retries on request. The error
/// already went to the error hooks installed by the entry point.
Future<void> _startOrShowFailure({
  required Future<void> Function() bootstrap,
  TransitionBuilder? overlayBuilder,
}) async {
  try {
    await bootstrap();
  } catch (error, stack) {
    debugPrint('Startup failed: $error\n$stack');
    if (!kIsWeb) FlutterNativeSplash.remove();
    runApp(
      StartupFailureApp(
        onRetry: () async {
          // DI registrations from the failed attempt would collide on retry.
          await getIt.reset();
          await _startOrShowFailure(bootstrap: bootstrap, overlayBuilder: overlayBuilder);
        },
      ),
    );
    return;
  }
  runApp(AppScaffold(overlayBuilder: overlayBuilder));
}

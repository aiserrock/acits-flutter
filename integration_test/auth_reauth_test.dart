import 'package:patrol/patrol.dart';

import 'package:di/di.dart';
import 'package:go_router/go_router.dart';
import 'package:shell/shell.dart' show AppRoutes;

import 'support/app_boot.dart';
import 'support/flows.dart';
import 'support/test_credentials.dart';

/// Сценарий 2 — повторная авторизация (авто-вход по сохранённой сессии).
///
/// Логинимся с нуля → сессия (refresh-токен) сохраняется в secure storage, а
/// выбранный приют — в prefs. Затем возвращаем роутер на splash — как при новом
/// запуске приложения. Splash повторно вызывает `tryRefreshLastAuth` (refresh из
/// secure storage) + `restoreShelter` (приют из prefs) и уводит СРАЗУ на root,
/// **не показывая форму логина**. Именно это и есть авто-вход: пользователь,
/// который уже входил, попадает на главный без повторного ввода логина/пароля.
///
/// Почему без нативного pressHome/openApp: в Patrol Dart-изолят при возврате
/// приложения в foreground общий, и связка finder'ов после openApp перестаёт
/// прокачивать кадры splash-навигации (проверено — root не появлялся). Повторный
/// проход splash в том же изоляте моделирует «второй запуск» надёжно и проверяет
/// ровно нужное поведение — редирект по сохранённой сессии мимо login.
///
/// Запуск: `patrol test --target integration_test/auth_reauth_test.dart --flavor dev`.
void main() {
  final creds = TestCredentials.fromEnv();

  patrolTest('returning user is auto-logged-in to root without credentials', ($) async {
    // 1) Первичный вход — сессия оседает в persistent storage.
    await bootApp($, freshSession: true);
    final flows = Flows($);
    await flows.login(creds);
    await flows.expectOnRoot();

    // 2) «Повторный запуск»: возвращаем роутер на splash. Новый SplashScreen в
    //    initState заново решает маршрут по уже сохранённой сессии.
    getIt<GoRouter>().go(AppRoutes.splash);

    // Splash держится минимум 2 c и делает refresh по сети; навигация уходит из
    // post-frame callback. pumpAndSettle не подходит (splash «занят» таймером/
    // сетью) — прокачиваем кадры фиксированное время, затем ждём root поллингом.
    for (var i = 0; i < 12; i++) {
      await $.pump(const Duration(seconds: 1));
    }

    // 3) Splash увёл на root по сохранённой сессии — форма логина не появлялась.
    await flows.expectOnRoot();
    flows.expectNotOnLogin();
  });
}

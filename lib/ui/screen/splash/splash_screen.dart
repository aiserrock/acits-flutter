import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:acits_flutter/util/splash/splash_control.dart';

/// Стартовый splash-роут. Не рисует собственный UI: держит тот же кадр, что и
/// нативный splash (Android/iOS) или DOM-splash (web) — сплошной фон #6776E0.
/// Пока он виден, решает, куда направить пользователя:
///  • первый запуск → онбординг;
///  • валидный refresh + запомненный приют → сразу главный (без выбора);
///  • валидный refresh без приюта → выбор приюта;
///  • нет/истёкший refresh → экран входа.
///
/// Нативный/DOM splash снимается [removeSplash] ровно в момент ухода на целевой
/// экран, поэтому переход бесшовный: авторизованный юзер на холодном старте
/// видит один непрерывный splash → root, без мелькания login и без отдельного
/// промежуточного экрана с другим дизайном.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _decideStartRoute());
  }

  /// Уйти на [route] и снять splash после отрисовки целевого экрана (следующий
  /// кадр), чтобы между splash и экраном не мелькнула пустота.
  void _goAndReveal(String route) {
    getIt<GoRouter>().go(route);
    WidgetsBinding.instance.addPostFrameCallback((_) => removeSplash());
  }

  Future<void> _decideStartRoute() async {
    final config = getIt<ConfigService>();
    final auth = getIt<AuthService>();

    if (config.isFirstLaunch) {
      Log.info('Splash: first launch → onboarding');
      _goAndReveal(AppRoutes.onboarding);
      return;
    }

    final refreshed = await auth.tryRefreshLastAuth();
    if (!mounted) return;
    if (!refreshed) {
      Log.info('Splash: no valid refresh → login');
      _goAndReveal(AppRoutes.login);
      return;
    }

    // Токен валиден — пробуем восстановить запомненный приют.
    final restored = await auth.restoreShelter();
    if (!mounted) return;
    if (restored) {
      Log.info('Splash: refresh ok + shelter restored → root');
      _goAndReveal(AppRoutes.root);
      return;
    }

    // Приют не запомнен/недоступен — уходим на выбор приюта.
    Log.info('Splash: refresh ok, no shelter → pick shelter');
    final list = await auth.getShelterList().catchError((Object e, StackTrace s) {
      Log.error('Splash: shelter list load failed', e, s);
      return null;
    });
    if (!mounted) return;
    final router = getIt<GoRouter>();
    if (list != null) {
      router.go(AppRoutes.login);
      router.push(AppRoutes.pickShelter, extra: <String, Object?>{'shelterList': list, 'autoSelectSingle': true});
    } else {
      router.go(AppRoutes.login);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => removeSplash());
  }

  @override
  Widget build(BuildContext context) {
    // Тот же цвет, что у нативного/DOM splash (#6776E0) — кадр совпадает пиксель
    // в пиксель, поэтому пока держится системный splash, разницы не видно, а на
    // web после снятия #splash под ним оказывается ровно такой же фон.
    return const ColoredBox(color: Color(0xFF6776E0));
  }
}

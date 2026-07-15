import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/ui/widget/app_logo.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Стартовый экран-заглушка. Пока показывает логотип и лоадер, решает, куда
/// направить пользователя:
///  • первый запуск → онбординг;
///  • валидный refresh + запомненный приют → сразу главный (без выбора);
///  • валидный refresh без приюта → выбор приюта;
///  • нет/истёкший refresh → экран входа.
///
/// Так убирается мелькание экрана логина при холодном старте авторизованного
/// пользователя (раньше login стартовал первым и через 1-2с редиректил).
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

  Future<void> _decideStartRoute() async {
    final router = getIt<GoRouter>();
    final config = getIt<ConfigService>();
    final auth = getIt<AuthService>();

    if (config.isFirstLaunch) {
      Log.info('Splash: first launch → onboarding');
      router.go(AppRoutes.onboarding);
      return;
    }

    final refreshed = await auth.tryRefreshLastAuth();
    if (!mounted) return;
    if (!refreshed) {
      Log.info('Splash: no valid refresh → login');
      router.go(AppRoutes.login);
      return;
    }

    // Токен валиден — пробуем восстановить запомненный приют.
    final restored = await auth.restoreShelter();
    if (!mounted) return;
    if (restored) {
      Log.info('Splash: refresh ok + shelter restored → root');
      router.go(AppRoutes.root);
      return;
    }

    // Приют не запомнен/недоступен — уходим на выбор приюта.
    Log.info('Splash: refresh ok, no shelter → pick shelter');
    final list = await auth.getShelterList().catchError((Object e, StackTrace s) {
      Log.error('Splash: shelter list load failed', e, s);
      return null;
    });
    if (!mounted) return;
    if (list != null) {
      router.go(AppRoutes.login);
      router.push(AppRoutes.pickShelter, extra: <String, Object?>{'shelterList': list, 'autoSelectSingle': true});
    } else {
      router.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogoBar(width: 180.0),
            const SizedBox(height: 32.0),
            CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}

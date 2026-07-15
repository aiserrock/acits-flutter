import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/res/lottie.dart';
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
  /// Все loading-анимации из assets/lottie (файлы *_loading.json). На каждый
  /// старт выбираем случайную — котики/лапки/собачка/дефолт.
  static const _loadingAnimations = <String>[
    LottieRes.loading,
    LottieRes.pawLoading,
    LottieRes.dogLoading,
    LottieRes.catsLoading,
  ];

  /// Минимальное время показа splash. Даже если маршрут решён мгновенно,
  /// пользователь видит splash не меньше этого срока (реальная загрузка дольше —
  /// ждём её). Держит на splash ровно 2 секунды, ни больше, ни меньше.
  static const _minSplashDuration = Duration(seconds: 2);

  /// Выбранная на этот запуск анимация. Фиксируется в initState, чтобы не
  /// меняться на ребилдах.
  late final String _loadingAnimation =
      _loadingAnimations[Random().nextInt(_loadingAnimations.length)];

  /// Момент, когда splash смонтирован — от него отсчитываем минимум показа.
  final Stopwatch _shownFor = Stopwatch();

  @override
  void initState() {
    super.initState();
    _shownFor.start();
    WidgetsBinding.instance.addPostFrameCallback((_) => _decideStartRoute());
  }

  /// Добить показ splash до [_minSplashDuration], если реальная логика решилась
  /// быстрее. Если она заняла ≥ минимума — не ждём ничего.
  Future<void> _ensureMinDuration() async {
    final left = _minSplashDuration - _shownFor.elapsed;
    if (left > Duration.zero) await Future<void>.delayed(left);
  }

  /// Уйти на [route] и снять splash после отрисовки целевого экрана (следующий
  /// кадр), чтобы между splash и экраном не мелькнула пустота. Перед уходом
  /// гарантируем минимальное время показа splash.
  Future<void> _goAndReveal(String route) async {
    await _ensureMinDuration();
    if (!mounted) return;
    getIt<GoRouter>().go(route);
    WidgetsBinding.instance.addPostFrameCallback((_) => removeSplash());
  }

  Future<void> _decideStartRoute() async {
    final config = getIt<ConfigService>();
    final auth = getIt<AuthService>();

    if (config.isFirstLaunch) {
      Log.info('Splash: first launch → onboarding');
      await _goAndReveal(AppRoutes.onboarding);
      return;
    }

    final refreshed = await auth.tryRefreshLastAuth();
    if (!mounted) return;
    if (!refreshed) {
      Log.info('Splash: no valid refresh → login');
      await _goAndReveal(AppRoutes.login);
      return;
    }

    // Токен валиден — пробуем восстановить запомненный приют.
    final restored = await auth.restoreShelter();
    if (!mounted) return;
    if (restored) {
      Log.info('Splash: refresh ok + shelter restored → root');
      await _goAndReveal(AppRoutes.root);
      return;
    }

    // Приют не запомнен/недоступен — уходим на выбор приюта.
    Log.info('Splash: refresh ok, no shelter → pick shelter');
    final list = await auth.getShelterList().catchError((Object e, StackTrace s) {
      Log.error('Splash: shelter list load failed', e, s);
      return null;
    });
    if (!mounted) return;
    await _ensureMinDuration();
    if (!mounted) return;
    final router = getIt<GoRouter>();
    if (list != null) {
      router.go(AppRoutes.login);
      router.push(
        AppRoutes.pickShelter,
        extra: <String, Object?>{'shelterList': list, 'autoSelectSingle': true},
      );
    } else {
      router.go(AppRoutes.login);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => removeSplash());
  }

  @override
  Widget build(BuildContext context) {
    // Кадр повторяет нативный/DOM splash: фон #6776E0, белая иконка (logo_splash)
    // по центру. Вместо CSS-спиннера #loader — случайная loading-lottie внизу на
    // ~18% высоты (тот же цвет фона, поэтому переход с нативного/DOM splash
    // остаётся бесшовным). На web между снятием DOM-#splash и отрисовкой целевого
    // экрана под ним оказывается этот кадр — без него мелькал бы голый фон.
    final size = MediaQuery.sizeOf(context);
    return ColoredBox(
      color: const Color(0xFF6776E0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Assets.image.logoSplash.svg(width: 80.0, height: 108.0)),
          Positioned(
            bottom: size.height * 0.18,
            child: Lottie.asset(_loadingAnimation, width: 96.0, height: 96.0, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}

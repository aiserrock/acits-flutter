import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:lottie/lottie.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/util/util.dart';
import 'package:auth/presentation/splash/update_gate_view.dart';

/// Стартовый splash-роут. Не рисует собственный UI: держит тот же кадр, что и
/// нативный splash (Android/iOS) или DOM-splash (web) — сплошной фон #6776E0.
/// Пока он виден, решает, куда направить пользователя:
///  • первый запуск → онбординг;
///  • валидный refresh + запомненный приют → сразу главный (без выбора);
///  • валидный refresh без приюта → выбор приюта;
///  • нет/истёкший refresh → экран входа.
///
/// Нативный/DOM splash снимается [SplashNavigator] ровно в момент ухода на
/// целевой экран, поэтому переход бесшовный: авторизованный юзер на холодном
/// старте видит один непрерывный splash → root, без мелькания login и без
/// отдельного промежуточного экрана с другим дизайном.
///
/// App-ассеты (логотип, loading-lottie) приходят параметрами; сессия/конфиг/
/// навигация — портами. Модуль не знает про app-ассеты и платформенный splash.
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    required this.authService,
    required this.configService,
    required this.navigator,
    required this.logo,
    required this.loadingAnimations,
    this.updatePolicy,
    super.key,
  });

  final AuthSessionApi authService;
  final AuthConfigInitializer configService;
  final SplashNavigator navigator;

  /// Логотип по центру (белая иконка на фоне #6776E0).
  final Widget logo;

  /// Пути к loading-lottie (`assets/lottie/*_loading.json`) — на старт выбирается
  /// случайная. Резолвятся из бандла приложения.
  final List<String> loadingAnimations;

  /// Remote update policy, checked before any route. `null` skips the check.
  final AppUpdatePolicy? updatePolicy;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Минимальное время показа splash. Даже если маршрут решён мгновенно,
  /// пользователь видит splash не меньше этого срока (реальная загрузка дольше —
  /// ждём её). Держит на splash ровно 2 секунды, ни больше, ни меньше.
  static const _minSplashDuration = Duration(seconds: 2);

  /// Выбранная на этот запуск анимация. Фиксируется в initState, чтобы не
  /// меняться на ребилдах.
  late final String _loadingAnimation = widget.loadingAnimations[Random().nextInt(widget.loadingAnimations.length)];

  /// Момент, когда splash смонтирован — от него отсчитываем минимум показа.
  final Stopwatch _shownFor = Stopwatch();

  /// Non-null while the update or kill-switch screen is shown instead of the splash.
  UpdateRequirement? _gate;

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

  /// Asks the remote policy first: an outdated or switched-off build stops here,
  /// before any network call that its old API contract could break.
  Future<void> _decideStartRoute() async {
    final requirement = await widget.updatePolicy?.check() ?? UpdateRequirement.none;
    if (!mounted) return;
    if (requirement != UpdateRequirement.none) {
      Log.info('Splash: update gate → ${requirement.name}');
      await _ensureMinDuration();
      if (!mounted) return;
      setState(() => _gate = requirement);
      widget.navigator.revealInPlace();
      return;
    }
    await _route();
  }

  void _continueWithoutUpdate() {
    setState(() => _gate = null);
    _route();
  }

  Future<void> _retryGate() async {
    final requirement = await widget.updatePolicy?.check() ?? UpdateRequirement.none;
    if (!mounted) return;
    if (requirement == UpdateRequirement.none) {
      _continueWithoutUpdate();
    } else {
      setState(() => _gate = requirement);
    }
  }

  Future<void> _route() async {
    final config = widget.configService;
    final auth = widget.authService;

    if (config.isFirstLaunch) {
      Log.info('Splash: first launch → onboarding');
      await _ensureMinDuration();
      if (!mounted) return;
      widget.navigator.toOnboardingAndReveal();
      return;
    }

    final refreshed = await auth.tryRefreshLastAuth();
    if (!mounted) return;
    if (!refreshed) {
      Log.info('Splash: no valid refresh → login');
      await _ensureMinDuration();
      if (!mounted) return;
      widget.navigator.toLoginAndReveal();
      return;
    }

    // Токен валиден — пробуем восстановить запомненный приют.
    final restored = await auth.restoreShelter();
    if (!mounted) return;
    if (restored) {
      Log.info('Splash: refresh ok + shelter restored → root');
      await _ensureMinDuration();
      if (!mounted) return;
      widget.navigator.toRootAndReveal();
      return;
    }

    // Приют не запомнен/недоступен — уходим на выбор приюта.
    Log.info('Splash: refresh ok, no shelter → pick shelter');
    final list = (await auth.getShelterList()).valueOrNull;
    if (list == null) {
      Log.error('Splash: shelter list load failed');
      if (!mounted) return;
      await _ensureMinDuration();
      if (!mounted) return;
      widget.navigator.toLoginAndReveal();
      return;
    }
    if (!mounted) return;
    await _ensureMinDuration();
    if (!mounted) return;
    widget.navigator.toPickShelterAndReveal(shelterList: list, autoSelectSingle: true);
  }

  @override
  Widget build(BuildContext context) {
    final gate = _gate;
    if (gate != null) {
      final policy = widget.updatePolicy!;
      return UpdateGateView(
        requirement: gate,
        message: policy.message,
        onUpdate: policy.openStore,
        onLater: _continueWithoutUpdate,
        onRetry: _retryGate,
      );
    }
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
          Center(child: widget.logo),
          Positioned(
            bottom: size.height * 0.18,
            child: Lottie.asset(_loadingAnimation, width: 96.0, height: 96.0, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}

import 'package:core/domain.dart' show Shelter;
import 'package:auth/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:di/di.dart';
import 'package:shell/navigation/app_router.dart';
import 'package:media/media.dart' show SearchTypeKey;
import 'package:shell/util/splash/splash_control.dart';

/// Реализация навигационного контракта модуля «Авторизация» через go_router и
/// [AppRoutes] приложения. Модуль зависит только от абстракции
/// [AuthRouterService]; конкретные пути живут здесь.
///
/// [GoRouter] резолвится из [getIt] лениво (он регистрируется рантайм-синглтоном
/// в initDi, а не через injectable — как в auth/deep-link/animals-сервисах).
@Injectable(as: AuthRouterService)
class AuthRouterServiceImpl implements AuthRouterService {
  const AuthRouterServiceImpl();

  GoRouter get _router => getIt<GoRouter>();

  @override
  void toRoot() => _router.go(AppRoutes.root);

  @override
  void toLogin() => _router.go(AppRoutes.login);

  @override
  void toRegistration() => _router.push(AppRoutes.registration);

  @override
  void toPickShelter({required List<Shelter> shelterList, required bool autoSelectSingle}) {
    _router.push(
      AppRoutes.pickShelter,
      extra: <String, Object?>{'shelterList': shelterList, 'autoSelectSingle': autoSelectSingle},
    );
  }

  @override
  Future<Shelter?> pickShelterFromSearch() => _router.push<Shelter>(AppRoutes.searchPath(SearchTypeKey.shelter));
}

/// Реализация навигации splash-роута: переходы + снятие нативного/DOM splash
/// после отрисовки целевого экрана (post-frame), чтобы переход был бесшовным.
@Injectable(as: SplashNavigator)
class SplashNavigatorImpl implements SplashNavigator {
  const SplashNavigatorImpl();

  GoRouter get _router => getIt<GoRouter>();

  void _revealAfterFrame() => WidgetsBinding.instance.addPostFrameCallback((_) => removeSplash());

  @override
  void toOnboardingAndReveal() {
    _router.go(AppRoutes.onboarding);
    _revealAfterFrame();
  }

  @override
  void toLoginAndReveal() {
    _router.go(AppRoutes.login);
    _revealAfterFrame();
  }

  @override
  void toRootAndReveal() {
    _router.go(AppRoutes.root);
    _revealAfterFrame();
  }

  @override
  void toPickShelterAndReveal({required List<Shelter> shelterList, required bool autoSelectSingle}) {
    _router
      ..go(AppRoutes.login)
      ..push(
        AppRoutes.pickShelter,
        extra: <String, Object?>{'shelterList': shelterList, 'autoSelectSingle': autoSelectSingle},
      );
    _revealAfterFrame();
  }
}

import 'package:core/domain.dart' show Shelter;
import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:di/di.dart';
import 'package:shell/gen/assets.gen.dart';
import 'package:localization/localization.dart';
import 'package:shell/res/lottie.dart';
import 'package:app_services/app_services.dart';
import 'package:shell/widget/app_logo.dart';
import 'package:shell/widget/app_version_label.dart';
import 'package:shell/widget/debug_drawer.dart';
import 'package:shell/widget/locale_switcher.dart';
import 'package:shell/widget/theme_switcher_tile.dart';
import 'package:easy_localization/easy_localization.dart';

/// Фабрики экранов модуля `auth`: собирают экраны, прокидывая сессионный фасад
/// ([AuthService] как [AuthSessionApi]), порты (config/debug/deeplink/splash),
/// навигацию и app-виджеты/ассеты. Держит app_router чистым, а app-специфику —
/// в одном месте.
abstract final class AuthScreenBindings {
  static Widget splash() {
    return SplashScreen(
      authService: getIt<AuthService>(),
      configService: getIt<ConfigService>(),
      navigator: getIt<SplashNavigator>(),
      logo: Assets.image.logoSplash.svg(width: 80.0, height: 108.0),
      loadingAnimations: const [LottieRes.loading, LottieRes.pawLoading, LottieRes.dogLoading, LottieRes.catsLoading],
    );
  }

  static Widget onboarding() {
    return BlocProvider(
      create: (_) => OnboardingBloc(configService: getIt<ConfigService>(), onboardingData: _onboardingData()),
      child: OnboardingScreen(
        router: getIt<AuthRouterService>(),
        closeIcon: Assets.icon.close.svg(),
        debugDrawer: const DebugDrawerContent(),
      ),
    );
  }

  static Widget login() {
    return LoginScreen(
      authService: getIt<AuthService>(),
      deepLinkService: getIt<DeepLinkService>(),
      debugService: getIt<DebugService>(),
      router: getIt<AuthRouterService>(),
      appLogo: const AppLogoBar(),
      themeToggle: const ThemeToggleButton(),
      localeSwitcher: const LocaleSwitcher(size: 18.0),
      versionLabel: const AppVersionLabel(),
      passwordVisibleIcon: Assets.icon.visible.svg(),
      passwordHiddenIcon: Assets.icon.visibleOff.svg(),
    );
  }

  static Widget registration() {
    return RegistrationScreen(
      authService: getIt<AuthService>(),
      router: getIt<AuthRouterService>(),
      appLogo: const AppLogoBar(),
      checkOnIcon: Assets.icon.checkOn.svg(),
      checkOffIcon: Assets.icon.checkOff.svg(),
    );
  }

  static Widget emailConfirmation(String link) {
    return EmailConfirmationScreen(authService: getIt<AuthService>(), confirmLink: link);
  }

  static Widget pickShelter({required bool autoSelectSingle, required List<Shelter>? shelterList}) {
    return PickShelterScreen(
      authService: getIt<AuthService>(),
      configService: getIt<ConfigService>(),
      router: getIt<AuthRouterService>(),
      appLogoLeading: const AppLogoLeading(),
      autoSelectSingle: autoSelectSingle,
      shelterList: shelterList,
    );
  }

  static List<OnboardingData> _onboardingData() => [
    OnboardingData(
      image: Assets.onboarding.news.svg(fit: BoxFit.fitWidth),
      title: LocaleKeys.onboardingNewsTitle.tr(),
      message: LocaleKeys.onboardingNewsMsg.tr(),
    ),
    OnboardingData(
      image: Assets.onboarding.plan.svg(fit: BoxFit.fitWidth),
      title: LocaleKeys.onboardingPlanTitle.tr(),
      message: LocaleKeys.onboardingPlanMsg.tr(),
    ),
    OnboardingData(
      image: Assets.onboarding.drugs.svg(fit: BoxFit.fitWidth),
      title: LocaleKeys.onboardingDrugsTitle.tr(),
      message: LocaleKeys.onboardingDrugsMsg.tr(),
    ),
    OnboardingData(
      image: Assets.onboarding.free.svg(fit: BoxFit.fitWidth),
      title: LocaleKeys.onboardingFreeTitle.tr(),
      message: LocaleKeys.onboardingFreeMsg.tr(),
    ),
  ];
}

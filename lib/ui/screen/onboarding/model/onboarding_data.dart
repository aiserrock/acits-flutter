import 'package:acits_flutter/export.dart';

class OnboardingData {
  final SvgGenImage image;
  final String title;
  final String message;

  OnboardingData({required this.image, required this.title, required this.message});
}

final onboardingData = <OnboardingData>[
  OnboardingData(
    image: Assets.onboarding.news,
    title: LocaleKeys.onboardingNewsTitle.tr(),
    message: LocaleKeys.onboardingNewsMsg.tr(),
  ),
  OnboardingData(
    image: Assets.onboarding.plan,
    title: LocaleKeys.onboardingPlanTitle.tr(),
    message: LocaleKeys.onboardingPlanMsg.tr(),
  ),
  OnboardingData(
    image: Assets.onboarding.drugs,
    title: LocaleKeys.onboardingDrugsTitle.tr(),
    message: LocaleKeys.onboardingDrugsMsg.tr(),
  ),
  OnboardingData(
    image: Assets.onboarding.free,
    title: LocaleKeys.onboardingFreeTitle.tr(),
    message: LocaleKeys.onboardingFreeMsg.tr(),
  ),
];

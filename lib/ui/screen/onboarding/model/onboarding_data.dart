import 'package:acits_flutter/export.dart';

class OnboardingData {
  final SvgGenImage image;
  final String title;
  final String message;

  OnboardingData({
    required this.image,
    required this.title,
    required this.message,
  });
}

final onboardingData = <OnboardingData>[
  OnboardingData(
    image: Assets.onboarding.news,
    title: StringRes.current.onboardingNewsTitle,
    message: StringRes.current.onboardingNewsMsg,
  ),
  OnboardingData(
    image: Assets.onboarding.plan,
    title: StringRes.current.onboardingPlanTitle,
    message: StringRes.current.onboardingPlanMsg,
  ),
  OnboardingData(
    image: Assets.onboarding.drugs,
    title: StringRes.current.onboardingDrugsTitle,
    message: StringRes.current.onboardingDrugsMsg,
  ),
  OnboardingData(
    image: Assets.onboarding.free,
    title: StringRes.current.onboardingFreeTitle,
    message: StringRes.current.onboardingFreeMsg,
  ),
];

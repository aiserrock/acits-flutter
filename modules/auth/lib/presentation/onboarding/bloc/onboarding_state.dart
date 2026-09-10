part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({required this.currentViewPage, required this.isLast});

  factory OnboardingState.initial() => const OnboardingState(currentViewPage: 0, isLast: false);

  final int currentViewPage;

  final bool isLast;

  @override
  List<Object> get props => [currentViewPage, isLast];
}

class OnboardingStateNeedCloseRoute extends OnboardingState {
  const OnboardingStateNeedCloseRoute() : super(currentViewPage: 0, isLast: true);
}

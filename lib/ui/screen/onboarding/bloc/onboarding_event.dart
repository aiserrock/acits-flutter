part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingEventOnNext extends OnboardingEvent {}

class OnboardingEventOnPosition extends OnboardingEvent {
  const OnboardingEventOnPosition(this.position);

  final int position;
}

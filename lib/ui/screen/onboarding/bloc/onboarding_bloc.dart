import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:acits_flutter/ui/screen/onboarding/model/onboarding_data.dart' as data;

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : _configService = getIt<ConfigService>(),
        super(OnboardingState.initial()) {
    on<OnboardingEventOnNext>(_onOnNextEvent);
    on<OnboardingEventOnPosition>(_onOnPosition);
  }

  final ConfigService _configService;

  List<data.OnboardingData> get onboardingData => data.onboardingData;

  @override
  Future<void> close() {
    _configService.setFirstLaunch();
    return super.close();
  }

  void _onOnNextEvent(OnboardingEventOnNext event, Emitter<OnboardingState> emit) {
    if (state.isLast) {
      emit(const OnboardingStateNeedCloseRoute());
      return;
    }
    final currentPage = state.currentViewPage + 1;
    final isLast = currentPage == onboardingData.length - 1;

    emit(OnboardingState(currentViewPage: currentPage, isLast: isLast));
  }

  void _onOnPosition(OnboardingEventOnPosition event, Emitter<OnboardingState> emit) {
    emit(OnboardingState(
        currentViewPage: event.position, isLast: event.position == onboardingData.length - 1));
  }
}

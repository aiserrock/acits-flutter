import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/auth_ports.dart';
import '../../../util/log.dart';
import '../model/onboarding_data.dart' as data;

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({required AuthConfigInitializer configService, required List<data.OnboardingData> onboardingData})
    : _configService = configService,
      _onboardingData = onboardingData,
      super(OnboardingState.initial()) {
    on<OnboardingEventOnNext>(_onOnNextEvent);
    on<OnboardingEventOnPosition>(_onOnPosition);
  }

  final AuthConfigInitializer _configService;
  final List<data.OnboardingData> _onboardingData;

  List<data.OnboardingData> get onboardingData => _onboardingData;

  @override
  Future<void> close() {
    _configService.setFirstLaunch();
    return super.close();
  }

  void _onOnNextEvent(OnboardingEventOnNext event, Emitter<OnboardingState> emit) {
    Log.debug('OnboardingBloc.onNext currentPage=${state.currentViewPage} isLast=${state.isLast}');
    if (state.isLast) {
      Log.info('OnboardingBloc.onNext ok: finished, closing route');
      emit(const OnboardingStateNeedCloseRoute());
      return;
    }
    final currentPage = state.currentViewPage + 1;
    final isLast = currentPage == onboardingData.length - 1;

    Log.info('OnboardingBloc.onNext ok: page=$currentPage');
    emit(OnboardingState(currentViewPage: currentPage, isLast: isLast));
  }

  void _onOnPosition(OnboardingEventOnPosition event, Emitter<OnboardingState> emit) {
    Log.debug('OnboardingBloc.onPosition position=${event.position}');
    emit(OnboardingState(currentViewPage: event.position, isLast: event.position == onboardingData.length - 1));
  }
}

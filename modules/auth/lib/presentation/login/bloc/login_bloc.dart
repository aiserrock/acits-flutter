import 'dart:async';

import 'package:core/domain.dart' show Shelter;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/presentation/login/login.dart';
import 'package:auth/util/util.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthSessionApi authService,
    required AuthDeepLinkHandler deepLinkService,
    required AuthDebugHook debugService,
    required AuthRouterService router,
  }) : _authService = authService,
       _deepLinkService = deepLinkService,
       _debugService = debugService,
       _router = router,
       super(const LoginState()) {
    on<LoginNameChanged>(_onNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPassObscureChanged>(_onPassObscureChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginOnDebug>(_onDebug);
    on<LoginTryRefreshLastSession>(_tryRefreshLastSession);
    on<LoginFocusTargetChanged>(_onFocusTargetChanged);

    _init();
    // Навигация на pick-shelter — ровно один раз на переход статуса в success.
    // Подписка сохраняется и отменяется в close() (иначе утечка листенера с
    // router.toPickShelter после ухода с экрана). Guard `_pickShelterHandled`
    // не даёт повторно дёргать getShelterList/push на каждой последующей
    // эмиссии, пока статус остаётся success (ввод, toggle пароля, смена фокуса).
    _statusSub = stream.listen((state) {
      if (state.status.isSuccess) {
        if (!_pickShelterHandled) {
          _pickShelterHandled = true;
          _pickShelter();
        }
      } else {
        _pickShelterHandled = false;
      }
    });
  }

  final AuthSessionApi _authService;
  final AuthDebugHook _debugService;
  final AuthDeepLinkHandler _deepLinkService;
  final AuthRouterService _router;

  StreamSubscription<LoginState>? _statusSub;
  bool _pickShelterHandled = false;

  @override
  Future<void> close() {
    _statusSub?.cancel();
    return super.close();
  }

  void _handleDeeplink(String initLink) {
    Future.delayed(const Duration(milliseconds: 32), () => _deepLinkService.onLinkHandle(initLink));
  }

  void _onNameChanged(LoginNameChanged event, Emitter<LoginState> emitter) {
    final name = Name.dirty(event.name);
    emitter(state.copyWith(name: name));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emitter) {
    final pass = Password.dirty(event.password);
    emitter(state.copyWith(password: pass));
  }

  void _onPassObscureChanged(LoginPassObscureChanged event, Emitter<LoginState> emitter) {
    emitter(state.copyWith(passObscured: !state.passObscured));
  }

  void _onFocusTargetChanged(LoginFocusTargetChanged event, Emitter<LoginState> emitter) {
    emitter(state.copyWith(focusTarget: event.focusTarget));
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emitter) async {
    final name = Name.dirty(state.name.value);
    final pass = Password.dirty(state.password.value);
    emitter(state.copyWith(password: pass, name: name));

    if (Formz.validate([name, pass])) {
      Log.debug('LoginBloc.submit: login attempt name=${state.name.value}');
      emitter(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        await _authService.login(state.name.value, state.password.value);
        Log.info('LoginBloc.submit ok: name=${state.name.value}');
        emitter(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e, s) {
        Log.error('LoginBloc.submit failed: name=${state.name.value}', e, s);
        emitter(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } else {
      Log.debug('LoginBloc.submit: validation failed');
    }
  }

  void _onDebug(LoginOnDebug event, Emitter<LoginState> emitter) {
    _debugService.openDebugScreen();
  }

  void _init() {
    final initLink = _deepLinkService.getResetInitLink();
    if (initLink != null) {
      _handleDeeplink(initLink);
      return;
    }
    // Авто-refresh при старте больше не здесь — им занимается SplashScreen
    // (initialLocation). LoginScreen открывается только когда refresh невалиден,
    // поэтому повторный refresh на входе не нужен и лишь мигал бы лоадером.
  }

  Future<void> _tryRefreshLastSession(LoginTryRefreshLastSession event, Emitter<LoginState> emitter) async {
    if (state.status.isInProgress) return;

    Log.debug('LoginBloc.tryRefreshLastSession');
    emitter(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final refreshed = await _authService.tryRefreshLastAuth();
    Log.info('LoginBloc.tryRefreshLastSession ok: refreshed=$refreshed');
    emitter(state.copyWith(status: FormzSubmissionStatus.canceled));
    if (refreshed) {
      _pickShelter();
    }
  }

  Future<void> _pickShelter() async {
    Log.debug('LoginBloc.pickShelter: fetching shelter list');
    final List<Shelter> list;
    try {
      list = await _authService.getShelterList();
    } catch (error, stack) {
      Log.error('LoginBloc.pickShelter failed to load shelter list', error, stack);
      return;
    }
    Log.info('LoginBloc.pickShelter ok: navigating to pick shelter');
    _router.toPickShelter(shelterList: list, autoSelectSingle: true);
  }
}

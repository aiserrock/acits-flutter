import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/service/link_handler/deep_link_service.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/screen/auth/login.dart';
import 'package:acits_flutter/util/logger/log.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
    : _authService = getIt<AuthService>(),
      _deepLinkService = getIt<DeepLinkService>(),
      _debugService = getIt<DebugService>(),
      super(const LoginState()) {
    on<LoginNameChanged>(_onNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPassObscureChanged>(_onPassObscureChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginOnDebug>(_onDebug);
    on<LoginTryRefreshLastSession>(_tryRefreshLastSession);
    on<LoginFocusTargetChanged>(_onFocusTargetChanged);

    _init();
    stream.listen((event) {
      if (state.status.isSuccess) _pickShelter();
    });
  }

  final AuthService _authService;
  final DebugService _debugService;
  final DeepLinkService _deepLinkService;

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

    add(const LoginTryRefreshLastSession());
  }

  Future<void> _tryRefreshLastSession(
    LoginTryRefreshLastSession event,
    Emitter<LoginState> emitter,
  ) async {
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
    final list = await _authService.getShelterList().catchError((error, stack) {
      Log.error('LoginBloc.pickShelter failed to load shelter list', error, stack);
      return null;
    });
    if (list != null) {
      Log.info('LoginBloc.pickShelter ok: navigating to pick shelter');
      getIt<GoRouter>().push(
        AppRoutes.pickShelter,
        extra: <String, Object?>{'shelterList': list, 'autoSelectSingle': true},
      );
    }
  }
}

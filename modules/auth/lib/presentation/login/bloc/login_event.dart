part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginNameChanged extends LoginEvent {
  const LoginNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginOnRegistration extends LoginEvent {
  const LoginOnRegistration();
}

class LoginOnDebug extends LoginEvent {
  const LoginOnDebug();
}

class LoginTryRefreshLastSession extends LoginEvent {
  const LoginTryRefreshLastSession();
}

class LoginPassObscureChanged extends LoginEvent {
  const LoginPassObscureChanged();
}

class LoginFocusTargetChanged extends LoginEvent {
  const LoginFocusTargetChanged(this.focusTarget);

  final FocusTarget focusTarget;

  @override
  List<Object> get props => [focusTarget];
}

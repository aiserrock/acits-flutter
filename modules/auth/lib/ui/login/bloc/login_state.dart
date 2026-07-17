part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    this.passObscured = true,
    this.focusTarget = FocusTarget.another,
  });

  final FormzSubmissionStatus status;
  final Name name;
  final Password password;
  final bool passObscured;
  final FocusTarget focusTarget;

  bool get isValid => name.isValid && password.isValid;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Name? name,
    Password? password,
    bool? passObscured,
    FocusTarget? focusTarget,
  }) {
    return LoginState(
      status: status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      passObscured: passObscured ?? this.passObscured,
      focusTarget: focusTarget ?? this.focusTarget,
    );
  }

  @override
  List<Object> get props => [status, name, password, passObscured, focusTarget];
}

class LoginInitial extends LoginState {}

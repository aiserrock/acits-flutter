import 'package:ui_kit/ui_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shimmer/shimmer.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/presentation/login/login.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    required this.router,
    required this.localeSwitcher,
    required this.versionLabel,
    required this.passwordVisibleIcon,
    required this.passwordHiddenIcon,
    super.key,
  });

  final AuthRouterService router;
  final Widget localeSwitcher;
  final Widget versionLabel;
  final Widget passwordVisibleIcon;
  final Widget passwordHiddenIcon;

  final _passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.name != current.name || previous.password != current.password || previous.status != current.status,
      listener: (_, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(LocaleKeys.loginAuthorizeError.tr())));
        }
      },
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 40.0),
          child: Column(
            children: [
              Card(
                child: Padding(padding: const EdgeInsets.all(16.0), child: _buildForm(context)),
              ),
              const SizedBox(height: 16.0),
              const _SubmitButton(),
              MaterialButton(
                onPressed: () => _onRegistration(context),
                child: Text(
                  LocaleKeys.loginToRegistration.tr(),
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 8.0),
              localeSwitcher,
              const SizedBox(height: 16.0),
              const Spacer(),
              Text(
                LocaleKeys.loginDescribeMsg.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12.0),
              versionLabel,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AutofillGroup(
              child: Column(
                children: [
                  _NameInput(passNode: _passNode),
                  _PasswordInput(
                    passNode: _passNode,
                    passwordVisibleIcon: passwordVisibleIcon,
                    passwordHiddenIcon: passwordHiddenIcon,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          transform: Transform.translate(offset: const Offset(-16.0, 8.0)).transform,
          child: MaterialButton(
            padding: const EdgeInsets.all(16.0),
            onPressed: () {},
            child: Text(LocaleKeys.loginForgetPass.tr(), style: TextStyle(color: context.appColors.textSecondary)),
          ),
        ),
      ],
    );
  }

  void _onRegistration(BuildContext context) {
    router.toRegistration();
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({this.passNode});

  final FocusNode? passNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: Focus(
          onFocusChange: (value) {
            if (value) _onFocusChanged(context);
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.name != current.name || previous.focusTarget != current.focusTarget,
            builder: (_, state) {
              return TextField(
                key: const Key('loginFormNameInputTextField'),
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(
                  errorText: state.name.isNotValid ? '' : null,
                  hintText: LocaleKeys.loginLoginHint.tr(),
                  labelText: LocaleKeys.loginLoginLabel.tr(),
                  floatingLabelStyle: TextStyle(
                    color: state.focusTarget.isName
                        ? Theme.of(context).colorScheme.primary
                        : context.appColors.textSecondary,
                  ),
                  errorStyle: const TextStyle(fontSize: 0.0),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                  ),
                ),
                cursorColor: Theme.of(context).colorScheme.primary,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) => context.read<LoginBloc>().add(LoginNameChanged(value)),
                onEditingComplete: () {
                  TextInput.finishAutofillContext();
                  FocusScope.of(context).requestFocus(passNode);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _onFocusChanged(BuildContext context) =>
      context.read<LoginBloc>().add(const LoginFocusTargetChanged(FocusTarget.name));
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({this.passNode, required this.passwordVisibleIcon, required this.passwordHiddenIcon});

  final FocusNode? passNode;
  final Widget passwordVisibleIcon;
  final Widget passwordHiddenIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: Focus(
          onFocusChange: (value) {
            if (value) _onFocusChanged(context);
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.password != current.password ||
                previous.passObscured != current.passObscured ||
                previous.focusTarget != current.focusTarget,
            builder: (_, state) {
              return TextField(
                key: const Key('loginFormPassInputTextField'),
                focusNode: passNode,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  labelText: LocaleKeys.loginPassLabel.tr(),
                  errorText: state.password.isNotValid ? '' : null,
                  floatingLabelStyle: TextStyle(
                    color: state.focusTarget.isPassword
                        ? Theme.of(context).colorScheme.primary
                        : context.appColors.textSecondary,
                  ),
                  errorStyle: const TextStyle(fontSize: 0.0),
                  suffixIcon: CupertinoButton(
                    onPressed: () => context.read<LoginBloc>().add(const LoginPassObscureChanged()),
                    child: state.passObscured ? passwordVisibleIcon : passwordHiddenIcon,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                  ),
                ),
                obscureText: state.passObscured,
                // TextInputType.text (не visiblePassword): при visiblePassword
                // Android/сторонние клавиатуры (SwiftKey и т.п.) подменяют ввод
                // на системную клаву. obscureText скрывает символы независимо.
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
                onEditingComplete: () {
                  TextInput.finishAutofillContext();
                  context.read<LoginBloc>().add(const LoginSubmitted());
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _onFocusChanged(BuildContext context) =>
      context.read<LoginBloc>().add(const LoginFocusTargetChanged(FocusTarget.password));
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        return state.status != FormzSubmissionStatus.inProgress
            ? _buildButton(context, state)
            : Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.primary,
                highlightColor: Theme.of(context).colorScheme.surface,
                child: _buildButton(context, state),
              );
      },
    );
  }

  PrimaryButton _buildButton(BuildContext context, LoginState state) {
    return PrimaryButton(
      onPressed: () => context.read<LoginBloc>().add(const LoginSubmitted()),
      onLongPress: () => context.read<LoginBloc>().add(const LoginOnDebug()),
      text: LocaleKeys.loginEntryBtn.tr().toUpperCase(),
    );
  }
}

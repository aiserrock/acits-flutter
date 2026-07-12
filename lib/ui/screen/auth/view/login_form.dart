import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/ui/screen/auth/login.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/ui/widget/app_version_label.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.name != current.name ||
          previous.password != current.password ||
          previous.status != current.status,
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
                child: Padding(padding: const EdgeInsets.all(16.0), child: _buildForm()),
              ),
              const SizedBox(height: 16.0),
              const _SubmitButton(),
              MaterialButton(
                onPressed: () => _onRegistration(context),
                child: Text(
                  LocaleKeys.loginToRegistration.tr(),
                  style: const TextStyle(color: ColorRes.accent),
                ),
              ),
              const SizedBox(height: 16.0),
              const Spacer(),
              Text(
                LocaleKeys.loginDescribeMsg.tr(),
                textAlign: TextAlign.center,
                style: StyleRes.content,
              ),
              const SizedBox(height: 12.0),
              const AppVersionLabel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AutofillGroup(
              child: Column(
                children: [
                  _NameInput(passNode: _passNode),
                  _PasswordInput(passNode: _passNode),
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
            child: Text(
              LocaleKeys.loginForgetPass.tr(),
              style: const TextStyle(color: ColorRes.textSecondary),
            ),
          ),
        ),
      ],
    );
  }

  void _onRegistration(BuildContext context) {
    context.push(AppRoutes.registration);
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
                    color: state.focusTarget.isName ? ColorRes.accent : ColorRes.textSecondary,
                  ),
                  errorStyle: const TextStyle(fontSize: 0.0),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorRes.accent, width: 2.0),
                  ),
                ),
                cursorColor: ColorRes.accent,
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
  const _PasswordInput({this.passNode});

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
                    color: state.focusTarget.isPassword ? ColorRes.accent : ColorRes.textSecondary,
                  ),
                  errorStyle: const TextStyle(fontSize: 0.0),
                  suffixIcon: CupertinoButton(
                    onPressed: () => context.read<LoginBloc>().add(const LoginPassObscureChanged()),
                    child: state.passObscured
                        ? Assets.icon.visible.svg()
                        : Assets.icon.visibleOff.svg(),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorRes.accent, width: 2.0),
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
                baseColor: ColorRes.accent,
                highlightColor: ColorRes.background,
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

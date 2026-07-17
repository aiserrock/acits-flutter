import 'package:acits_core/acits_core.dart';
import 'package:acits_domain/acits_domain.dart' show EmailConfirmException;
import 'package:acits_ui_kit/acits_ui_kit.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/auth_session_api.dart';
import '../auth_l10n_keys.dart';
import 'cubit/email_confirm_cubit.dart';

const _switchDuration = Duration(milliseconds: 300);

/// Экран подтверждения электронной почты при регистрации.
class EmailConfirmationScreen extends StatelessWidget {
  const EmailConfirmationScreen({required this.authService, required this.confirmLink, super.key});

  final AuthSessionApi authService;
  final String confirmLink;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmailConfirmCubit(authService: authService, confirmLink: confirmLink),
      child: const _EmailConfirmationView(),
    );
  }
}

class _EmailConfirmationView extends StatelessWidget {
  const _EmailConfirmationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AuthL10nKeys.regEmaiConfirmation.tr(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<EmailConfirmCubit, DataState<void>>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: _switchDuration,
              reverseDuration: _switchDuration,
              child: DataStateBuilder<void>(
                key: ValueKey(state.runtimeType),
                state: state,
                loader: (_) => const LoaderHolderWidget(),
                builder: (context, _) => SuccessHolderWidget(
                  title: AuthL10nKeys.regEmailConfirmed.tr(),
                  message: AuthL10nKeys.regEmailConfirmSentMsg.tr(),
                  button: AuthL10nKeys.commonClose.tr().toUpperCase(),
                  onPressed: Navigator.of(context).pop,
                ),
                errorBuilder: (context, error) {
                  final isReject = error is DioException && error.error is EmailConfirmException;
                  return ErrorHolderWidget(
                    title: isReject ? AuthL10nKeys.regRegisterRejectTitle.tr() : null,
                    message: isReject ? AuthL10nKeys.regRegisterRejectMsg.tr() : null,
                    error: isReject ? null : error,
                    onPressed: context.read<EmailConfirmCubit>().retry,
                    button: AuthL10nKeys.commonRepeat.tr().toUpperCase(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

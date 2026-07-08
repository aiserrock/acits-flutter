import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/registration/cubit/email_confirm_cubit.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/ui/widget/success_holder.dart';

const _switchDuration = Duration(milliseconds: 300);

/// Экран подтверждения электронной почты при регистрации.
class EmailConfirmationScreen extends StatelessWidget {
  const EmailConfirmationScreen({required this.confirmLink, super.key});

  final String confirmLink;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmailConfirmCubit(confirmLink: confirmLink),
      child: const _EmailConfirmationView(),
    );
  }
}

class _EmailConfirmationView extends StatelessWidget {
  const _EmailConfirmationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: ColorRes.accent),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          LocaleKeys.regEmaiConfirmation.tr(),
          style: const TextStyle(color: ColorRes.textPrimary),
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
                  title: LocaleKeys.regEmailConfirmed.tr(),
                  message: LocaleKeys.regEmailConfirmSentMsg.tr(),
                  button: LocaleKeys.commonClose.tr().toUpperCase(),
                  onPressed: Navigator.of(context).pop,
                ),
                errorBuilder: (context, error) {
                  final isReject = error is DioException && error.error is EmailConfirmException;
                  return ErrorHolderWidget(
                    title: isReject ? LocaleKeys.regRegisterRejectTitle.tr() : null,
                    message: isReject ? LocaleKeys.regRegisterRejectMsg.tr() : null,
                    error: isReject ? null : error,
                    onPressed: context.read<EmailConfirmCubit>().retry,
                    button: LocaleKeys.commonRepeat.tr().toUpperCase(),
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

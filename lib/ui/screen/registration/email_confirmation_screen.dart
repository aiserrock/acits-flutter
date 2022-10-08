import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/ui/widget/success_holder.dart';

const _switchDuration = Duration(milliseconds: 300);

class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({
    required this.confirmLink,
    Key? key,
  }) : super(key: key);

  final String confirmLink;

  @override
  State<EmailConfirmationScreen> createState() => _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  _EmailConfirmationScreenState() : _authService = getIt<AuthService>();

  final AuthService _authService;
  var _state = WidgetState<Object>()..loading();

  @override
  void initState() {
    super.initState();
    _confirmEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorRes.accent,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          StringRes.current.regEmaiConfirmation,
          style: const TextStyle(color: ColorRes.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: _switchDuration,
          reverseDuration: _switchDuration,
          child: StateBuilder(
            key: UniqueKey(),
            state: _state,
            builder: (BuildContext context, data) {
              return SuccessHolderWidget(
                title: StringRes.current.regEmailConfirmed,
                message: StringRes.current.regEmailConfirmSentMsg,
                button: StringRes.current.commonClose.toUpperCase(),
                onPressed: Navigator.of(context).pop,
              );
            },
            loader: (_) => const LoaderHolderWidget(),
            errorBuilder: (BuildContext context, Object? error) {
              return ErrorHolderWidget(
                title: error is DioError && error.error is EmailConfirmException
                    ? StringRes.current.regRegisterRejectTitle
                    : null,
                message: error is DioError && error.error is EmailConfirmException
                    ? StringRes.current.regRegisterRejectMsg
                    : null,
                error: error is DioError && error.error is EmailConfirmException ? null : error,
                onPressed: _repeat,
                button: StringRes.current.commonRepeat.toUpperCase(),
              );
            },
          ),
        ),
      ),
    );
  }

  void _repeat() {
    setState(() => _state = WidgetState<Object>()..loading());
    _confirmEmail();
  }

  void _onSuccess() {
    setState(() => _state = WidgetState<Object>(Object()));
  }

  void _onError(dynamic error) {
    setState(() => _state = WidgetState<Object>()..error = error);
  }

  void _confirmEmail() {
    _authService
        .confirmEmail(widget.confirmLink)
        .then((value) => _onSuccess())
        .catchError(_onError);
  }
}

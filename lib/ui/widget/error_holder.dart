import 'dart:io';
import 'dart:math';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/res/lottie.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

const _sizePart = .75;

class ErrorHolderWidget extends StatelessWidget {
  const ErrorHolderWidget({
    this.error,
    this.assetPath,
    this.onPressed,
    this.title,
    this.message,
    this.button,
    super.key,
  });

  final String? assetPath;
  final String? title;
  final String? message;
  final String? button;
  final Object? error;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, cons) {
        final size = min(cons.maxHeight, cons.maxWidth) * _sizePart;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(assetPath ?? LottieRes.crashBox, height: size, width: size),
                const SizedBox(height: 24.0),
                Text(
                  title ?? error?.title ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Text(
                  message ?? error?.message ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                PrimaryButton(onPressed: () => onPressed?.call(), text: button ?? LocaleKeys.commonReloadBtn.tr()),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension _ErrorX on Object {
  String get title {
    if (this is DioException) {
      return LocaleKeys.errorInternetFail.tr();
    }
    switch (runtimeType) {
      case const (MessagedException):
        return LocaleKeys.commonError.tr();
      case const (SocketException):
        return LocaleKeys.errorInternetFail.tr();
      default:
        return LocaleKeys.commonError.tr();
    }
  }

  String get message {
    if (this is DioException) {
      return LocaleKeys.errorInternetFail.tr();
    }
    switch (runtimeType) {
      case const (MessagedException):
        return LocaleKeys.errorDefaultMsg.tr();
      case const (SocketException):
        return LocaleKeys.errorInternetFailMsg.tr();
      default:
        return LocaleKeys.errorDefaultMsg.tr();
    }
  }
}

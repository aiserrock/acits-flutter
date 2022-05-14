import 'dart:io';
import 'dart:math';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/lottie.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const _sizePart = .75;

class ErrorHolderWidget extends StatelessWidget {
  const ErrorHolderWidget({
    this.error,
    this.assetPath,
    this.onPressed,
    this.title,
    this.message,
    this.button,
    Key? key,
  }) : super(key: key);

  final String? assetPath;
  final String? title;
  final String? message;
  final String? button;
  final Object? error;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, cons) {
      final size = min(cons.maxHeight, cons.maxWidth) * _sizePart;
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              assetPath ?? LottieRes.crashBox,
              height: size,
              width: size,
            ),
            const SizedBox(height: 24.0),
            Text(
              error?.title ?? '',
              style: StyleRes.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              error?.message ?? '',
              style: StyleRes.content,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrimaryButton(
                onPressed: () => onPressed?.call(),
                text: StringRes.current.commonReloadBtn,
              ),
            )
          ],
        ),
      );
    });
  }
}

extension _ErrorX on Object {
  String get title {
    switch (runtimeType) {
      case MessagedException:
        return StringRes.current.commonError;
      case SocketException:
        return StringRes.current.errorInternetFail;
      default:
        return StringRes.current.commonError;
    }
  }

  String get message {
    switch (runtimeType) {
      case MessagedException:
        return StringRes.current.errorDefaultMsg;
      case SocketException:
        return StringRes.current.errorInternetFailMsg;
      default:
        return StringRes.current.errorDefaultMsg;
    }
  }
}

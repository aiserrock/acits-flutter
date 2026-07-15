import 'dart:math';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const _sizePart = .75;

class SuccessHolderWidget extends StatelessWidget {
  const SuccessHolderWidget({
    this.assetPath,
    this.onPressed,
    this.title,
    this.message,
    this.button,
    this.secondButton,
    this.onSecondPressed,
    super.key,
  });

  final String? assetPath;
  final String? title;
  final String? message;
  final String? button;
  final VoidCallback? onPressed;
  final String? secondButton;
  final VoidCallback? onSecondPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, cons) {
        final size = min(cons.maxHeight, cons.maxWidth) * _sizePart;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(child: _buildCaption(context, size)),
              if (onPressed != null && button != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: PrimaryButton(
                    onPressed: () => onPressed?.call(),
                    text: button ?? LocaleKeys.commonRepeat.tr(),
                  ),
                ),
              if (onSecondPressed != null && secondButton != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: PrimaryButton(
                    onPressed: () => onSecondPressed?.call(),
                    text: secondButton,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCaption(BuildContext context, double size) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(assetPath ?? LottieRes.success, height: size, width: size),
          const SizedBox(height: 24.0),
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            message ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

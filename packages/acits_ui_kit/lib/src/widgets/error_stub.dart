import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/primary_button.dart';

class ErrorStubWidget extends StatelessWidget {
  const ErrorStubWidget({
    required this.onPressed,
    this.showImage = true,
    this.height,
    this.image,
    super.key,
  });

  final double? height;
  final VoidCallback onPressed;
  final bool showImage;

  /// Иллюстрация-заглушка. Ассет отдаёт приложение (ui_kit ассетами приложения
  /// не владеет); при [showImage] == false или `null` — не показывается.
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return height != null
        ? SizedBox(
            height: height,
            child: Center(child: _buildContent(context)),
          )
        : _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    final showStub = showImage && image != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showStub) image!,
          if (showStub) const SizedBox(height: 32.0),
          Text('commonErrorStubTitle'.tr(), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12.0),
          Text(
            'commonErrorStubMsg'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(onPressed: onPressed, text: 'commonReloadBtn'.tr()),
        ],
      ),
    );
  }
}

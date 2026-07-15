import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorStubWidget extends StatelessWidget {
  const ErrorStubWidget({required this.onPressed, this.showImage = true, this.height, super.key});

  final double? height;
  final VoidCallback onPressed;
  final bool showImage;

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showImage) Assets.image.errorStub.svg(),
          if (showImage) const SizedBox(height: 32.0),
          Text(LocaleKeys.commonErrorStubTitle.tr(), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12.0),
          Text(
            LocaleKeys.commonErrorStubMsg.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(onPressed: onPressed, text: LocaleKeys.commonReloadBtn.tr()),
        ],
      ),
    );
  }
}

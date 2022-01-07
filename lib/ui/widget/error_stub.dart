import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/material.dart';

class ErrorStubWidget extends StatelessWidget {
  const ErrorStubWidget({
    required this.onPressed,
    this.showImage = true,
    this.height,
    Key? key,
  }) : super(key: key);

  final double? height;
  final VoidCallback onPressed;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return height != null
        ? SizedBox(
            height: height,
            child: Center(
              child: _buildContent(),
            ),
          )
        : _buildContent();
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showImage) Assets.image.errorStub.svg(),
          if (showImage) const SizedBox(height: 32.0),
          Text(
            StringRes.current.commonErrorStubTitle,
            style: StyleRes.title,
          ),
          const SizedBox(height: 12.0),
          Text(
            StringRes.current.commonErrorStubMsg,
            style: StyleRes.content.copyWith(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(
            onPressed: onPressed,
            text: StringRes.current.commonReloadBtn,
          ),
        ],
      ),
    );
  }
}

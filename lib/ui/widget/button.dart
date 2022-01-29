import 'package:acits_flutter/res/color.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    this.text,
    this.child,
    this.isFill = true,
    this.onLongPress,
    Key? key,
  })  : assert(text != null || child != null),
        super(key: key);

  final VoidCallback onPressed;
  final String? text;
  final Widget? child;
  final bool isFill;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 16.0),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        ),
        backgroundColor: MaterialStateProperty.all(ColorRes.primaryButton),
      ),
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    return isFill
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child ?? Text(text!),
            ],
          )
        : child ?? Text(text!);
  }
}

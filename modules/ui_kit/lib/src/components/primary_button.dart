import 'package:flutter/material.dart';

/// Акцентная кнопка. Цвета/текст берутся из [ElevatedButtonThemeData] темы;
/// здесь фиксируется только форма (радиус 8) и режим растяжки.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({required this.onPressed, this.text, this.child, this.isFill = true, this.onLongPress, super.key})
    : assert(text != null || child != null);

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final bool isFill;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      ),
      child: isFill
          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [child ?? Text(text!)])
          : child ?? Text(text!),
    );
  }
}

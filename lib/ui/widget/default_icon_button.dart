import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultIconButton extends StatelessWidget {
  const DefaultIconButton({required this.icon, required this.onPressed, super.key});

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(.0),
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: .55),
          borderRadius: BorderRadius.circular(40.0),
        ),
        padding: const EdgeInsets.all(14.0),
        child: icon,
      ),
    );
  }
}

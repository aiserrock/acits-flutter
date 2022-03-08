import 'package:flutter/cupertino.dart';

import 'package:acits_flutter/export.dart';

class DefaultIconButton extends StatelessWidget {
  const DefaultIconButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(.0),
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: ColorRes.foreground.withOpacity(.55),
          borderRadius: BorderRadius.circular(40.0),
        ),
        padding: const EdgeInsets.all(14.0),
        child: icon,
      ),
    );
  }
}

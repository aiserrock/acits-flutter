import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:flutter/material.dart';

/// BottomSheet c действиями и кнопкой отмены
Widget bsPeriodSelectorActions(BuildContext context, Map<Widget, Function()> actions) {
  return _buildIosStyle(context, actions);
}

Widget _buildIosStyle(BuildContext context, Map<Widget, Function()> actions) {
  Widget buildAction(
    Widget title,
    VoidCallback onPressed, {
    bool islast = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          child: InkWell(
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [title],
              ),
            ),
            onTap: onPressed,
          ),
        ),
        if (!islast) const Divider(thickness: 1.0, height: 1.0),
      ],
    );
  }

  final actionTiles = actions.entries
      .map<Widget>(
        (action) => buildAction(
          action.key,
          action.value,
          islast: action == actions.entries.last,
        ),
      )
      .toList();

  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: ColorRes.foreground,
              child: Column(
                children: actionTiles,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: ColorRes.foreground,
              child: Material(
                child: InkWell(
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringRes.current.commonCancel,
                          style: StyleRes.subTitle.copyWith(color: ColorRes.accent),
                        )
                      ],
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

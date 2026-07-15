import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// BottomSheet c действиями и кнопкой отмены
Widget bsSelectorActions(BuildContext context, Map<Widget, Function()> actions) {
  return _buildIosStyle(context, actions);
}

Widget _buildIosStyle(BuildContext context, Map<Widget, Function()> actions) {
  Widget buildAction(Widget title, VoidCallback onPressed, {bool islast = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [title]),
            ),
          ),
        ),
        if (!islast) const Divider(thickness: 1.0, height: 1.0),
      ],
    );
  }

  final actionTiles = actions.entries
      .map<Widget>(
        (action) => buildAction(action.key, action.value, islast: action == actions.entries.last),
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
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Column(children: actionTiles),
            ),
          ),
          const SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Material(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: InkWell(
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.commonCancel.tr(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
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

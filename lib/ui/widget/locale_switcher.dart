import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:acits_flutter/domain/app_locale.dart';

/// Компактный переключатель языка: два флажка ru/en в ряд.
///
/// Активный язык подсвечен (рамка + полная непрозрачность), неактивный
/// приглушён. Тап по флагу сразу применяет локаль через `context.setLocale`
/// (easy_localization) — без промежуточного bottom-sheet.
class LocaleSwitcher extends StatelessWidget {
  const LocaleSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final current = AppLocale.fromLanguageCode(context.locale.languageCode);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in AppLocale.values) ...[
          _FlagButton(item: item, selected: item == current, onTap: () => context.setLocale(item.locale)),
          if (item != AppLocale.values.last) const SizedBox(width: 12.0),
        ],
      ],
    );
  }
}

class _FlagButton extends StatelessWidget {
  const _FlagButton({required this.item, required this.selected, required this.onTap});

  final AppLocale item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: selected ? 1.0 : 0.45,
        child: Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: selected ? scheme.primary : Colors.transparent, width: 2.0),
          ),
          child: item.flag.svg(width: 28.0, height: 28.0),
        ),
      ),
    );
  }
}

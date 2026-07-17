import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Поддерживаемые языки приложения с флагами (для переключателя локали).
///
/// Перенесено из app `domain/app_locale.dart` (подмножество, нужное экрану
/// личного кабинета). Флаги — SVG из бандла приложения (`assets/icon/*.svg`),
/// резолвятся по пути через [SvgPicture.asset]. Значения совпадают с исходными.
enum _AppLocale {
  ru(locale: Locale('ru'), flagAsset: 'assets/icon/flag_ru.svg'),
  en(locale: Locale('en'), flagAsset: 'assets/icon/flag_en.svg');

  const _AppLocale({required this.locale, required this.flagAsset});

  final Locale locale;
  final String flagAsset;

  static _AppLocale fromLanguageCode(String? code) {
    return _AppLocale.values.firstWhere(
      (e) => e.locale.languageCode == code?.toLowerCase(),
      orElse: () => _AppLocale.ru,
    );
  }
}

/// Компактный переключатель языка: два флажка ru/en в ряд.
///
/// Активный язык подсвечен (рамка + полная непрозрачность), неактивный
/// приглушён. Тап по флагу сразу применяет локаль через `context.setLocale`
/// (easy_localization) — без промежуточного bottom-sheet.
class LocaleSwitcher extends StatelessWidget {
  const LocaleSwitcher({this.size = 20.0, super.key});

  /// Размер флага в пикселях (без учёта рамки/паддинга).
  final double size;

  @override
  Widget build(BuildContext context) {
    final current = _AppLocale.fromLanguageCode(context.locale.languageCode);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in _AppLocale.values) ...[
          _FlagButton(item: item, size: size, selected: item == current, onTap: () => context.setLocale(item.locale)),
          if (item != _AppLocale.values.last) const SizedBox(width: 8.0),
        ],
      ],
    );
  }
}

class _FlagButton extends StatelessWidget {
  const _FlagButton({required this.item, required this.size, required this.selected, required this.onTap});

  final _AppLocale item;
  final double size;
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
        opacity: selected ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: selected ? scheme.primary : Colors.transparent, width: 1.5),
          ),
          child: SvgPicture.asset(item.flagAsset, width: size, height: size),
        ),
      ),
    );
  }
}

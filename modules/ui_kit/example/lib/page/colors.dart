import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// ColorScheme роли Material 3 + семантические токены [AppColors].
///
/// Каждая роль показана сразу в обеих темах — свотчи Light и Dark стоят бок о
/// бок и читаются напрямую из [AppTheme.light] / [AppTheme.dark], поэтому не
/// зависят от активной темы панели. Рядом — описание назначения роли (где
/// применяется в приложении).
class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final light = AppTheme.light.colorScheme;
    final dark = AppTheme.dark.colorScheme;
    const lightApp = AppColors.light();
    const darkApp = AppColors.dark();

    final schemeRoles = <_Role>[
      _Role('primary', light.primary, dark.primary, 'Бренд-акцент: кнопки, FAB, активные элементы'),
      _Role('onPrimary', light.onPrimary, dark.onPrimary, 'Текст/иконки поверх акцентного фона'),
      _Role(
        'primaryContainer',
        light.primaryContainer,
        dark.primaryContainer,
        'Приглушённый акцентный контейнер',
      ),
      _Role('secondary', light.secondary, dark.secondary, 'Вторичный акцент'),
      _Role(
        'secondaryContainer',
        light.secondaryContainer,
        dark.secondaryContainer,
        'Контейнер вторичного акцента',
      ),
      _Role('tertiary', light.tertiary, dark.tertiary, 'Третичный акцент (редкие выделения)'),
      _Role('error', light.error, dark.error, 'Ошибки, деструктивные действия'),
      _Role('errorContainer', light.errorContainer, dark.errorContainer, 'Фон блоков ошибок'),
      _Role('surface', light.surface, dark.surface, 'Основной фон экранов и Scaffold'),
      _Role('onSurface', light.onSurface, dark.onSurface, 'Основной текст и иконки на surface'),
      _Role(
        'surfaceContainerLow',
        light.surfaceContainerLow,
        dark.surfaceContainerLow,
        'Карточки, приподнятые блоки',
      ),
      _Role(
        'surfaceContainerHigh',
        light.surfaceContainerHigh,
        dark.surfaceContainerHigh,
        'Более приподнятые контейнеры',
      ),
      _Role('outline', light.outline, dark.outline, 'Границы, разделители'),
      _Role(
        'outlineVariant',
        light.outlineVariant,
        dark.outlineVariant,
        'Мягкие границы, рамки свотчей',
      ),
    ];

    final appRoles = <_Role>[
      _Role(
        'indicatorActive',
        lightApp.indicatorActive,
        darkApp.indicatorActive,
        'Активный индикатор страниц (пейджинг)',
      ),
      _Role(
        'indicatorInactive',
        lightApp.indicatorInactive,
        darkApp.indicatorInactive,
        'Неактивный индикатор страниц',
      ),
      _Role('inactiveIcon', lightApp.inactiveIcon, darkApp.inactiveIcon, 'Неактивные иконки'),
      _Role(
        'textSecondary',
        lightApp.textSecondary,
        darkApp.textSecondary,
        'Вторичный текст, подписи, caption',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Colors')),
      body: ListView(
        children: [
          const _ColumnLegend(),
          _SectionHeader('ColorScheme (Material 3)'),
          for (final role in schemeRoles) _RoleRow(role),
          const Divider(height: 32.0),
          _SectionHeader('AppColors (ThemeExtension)'),
          for (final role in appRoles) _RoleRow(role),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

/// Роль темы: имя, light-цвет, dark-цвет, описание назначения.
class _Role {
  const _Role(this.name, this.light, this.dark, this.description);

  final String name;
  final Color light;
  final Color dark;
  final String description;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

/// Шапка-легенда: подписи над колонками свотчей «Light / Dark».
class _ColumnLegend extends StatelessWidget {
  const _ColumnLegend();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0.0),
      child: Row(
        children: [
          SizedBox(
            width: 40.0,
            child: Text('Light', style: style, textAlign: TextAlign.center),
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 40.0,
            child: Text('Dark', style: style, textAlign: TextAlign.center),
          ),
          const SizedBox(width: 12.0),
          const Spacer(),
        ],
      ),
    );
  }
}

/// Строка одной роли: два свотча (light+dark) + имя, hex обеих тем и описание.
class _RoleRow extends StatelessWidget {
  const _RoleRow(this.role);

  final _Role role;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Swatch(color: role.light, foreground: role.dark),
          const SizedBox(width: 8.0),
          _Swatch(color: role.dark, foreground: role.light),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role.name, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 2.0),
                Text(role.description, style: theme.textTheme.bodySmall),
                const SizedBox(height: 2.0),
                Text(
                  '${_hex(role.light)}  ·  ${_hex(role.dark)}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _hex(Color color) =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

/// Квадратный свотч цвета с «Aa» поверх (демонстрация читаемости пары цветов).
class _Swatch extends StatelessWidget {
  const _Swatch({required this.color, required this.foreground});

  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Text(
        'Aa',
        style: TextStyle(color: foreground, fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
    );
  }
}

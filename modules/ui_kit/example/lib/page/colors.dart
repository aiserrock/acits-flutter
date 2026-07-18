import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// ColorScheme роли Material 3 + семантические токены [AppColors].
///
/// Light/dark переключается панельным плагином темы (MediaQuery brightness),
/// каждый свотч читается из активной схемы — свотчи флипаются вместе с темой.
class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final appColors = context.appColors;

    final schemeRoles = <(String, Color, Color)>[
      ('primary', scheme.primary, scheme.onPrimary),
      ('onPrimary', scheme.onPrimary, scheme.primary),
      ('primaryContainer', scheme.primaryContainer, scheme.onPrimaryContainer),
      ('secondary', scheme.secondary, scheme.onSecondary),
      ('secondaryContainer', scheme.secondaryContainer, scheme.onSecondaryContainer),
      ('tertiary', scheme.tertiary, scheme.onTertiary),
      ('error', scheme.error, scheme.onError),
      ('errorContainer', scheme.errorContainer, scheme.onErrorContainer),
      ('surface', scheme.surface, scheme.onSurface),
      ('onSurface', scheme.onSurface, scheme.surface),
      ('surfaceContainerLow', scheme.surfaceContainerLow, scheme.onSurface),
      ('surfaceContainerHigh', scheme.surfaceContainerHigh, scheme.onSurface),
      ('outline', scheme.outline, scheme.surface),
      ('outlineVariant', scheme.outlineVariant, scheme.onSurface),
    ];

    final appRoles = <(String, Color)>[
      ('indicatorActive', appColors.indicatorActive),
      ('indicatorInactive', appColors.indicatorInactive),
      ('inactiveIcon', appColors.inactiveIcon),
      ('textSecondary', appColors.textSecondary),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Colors')),
      body: ListView(
        children: [
          _SectionHeader('ColorScheme (Material 3)'),
          for (final (name, bg, fg) in schemeRoles)
            _SchemeTile(name: name, background: bg, foreground: fg),
          const Divider(height: 32.0),
          _SectionHeader('AppColors (ThemeExtension)'),
          for (final (name, color) in appRoles)
            _SchemeTile(name: name, background: color, foreground: null),
        ],
      ),
    );
  }
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

class _SchemeTile extends StatelessWidget {
  const _SchemeTile({required this.name, required this.background, required this.foreground});

  final String name;
  final Color background;

  /// Текст «Aa» поверх свотча (демонстрация читаемости). Null — без текста.
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hex = '#${background.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
    return ListTile(
      leading: Container(
        height: 48.0,
        width: 48.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: foreground == null
            ? null
            : Text(
                'Aa',
                style: TextStyle(color: foreground, fontWeight: FontWeight.w600),
              ),
      ),
      title: Text(name),
      subtitle: Text(hex, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}

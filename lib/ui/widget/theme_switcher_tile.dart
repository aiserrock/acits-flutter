import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/cubit/theme_cubit.dart';

/// Переключатель темы (System/Light/Dark) для бокового меню.
///
/// Три [RadioListTile] под заголовком-секцией, сгруппированные в [RadioGroup]
/// (актуальный API Material 3). Отмечает текущий режим из [ThemeCubit] и
/// переключает его по тапу. Все подписи — из локализации.
class ThemeSwitcherTile extends StatelessWidget {
  const ThemeSwitcherTile({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeCubit>().state;

    return RadioGroup<ThemeMode>(
      groupValue: mode,
      onChanged: (selected) {
        if (selected != null) context.read<ThemeCubit>().setMode(selected);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(title: Text(LocaleKeys.themeSectionTitle.tr(), style: Theme.of(context).textTheme.titleLarge)),
          _option(context, ThemeMode.system, LocaleKeys.themeSystem.tr()),
          _option(context, ThemeMode.light, LocaleKeys.themeLight.tr()),
          _option(context, ThemeMode.dark, LocaleKeys.themeDark.tr()),
        ],
      ),
    );
  }

  Widget _option(BuildContext context, ThemeMode value, String label) {
    return RadioListTile<ThemeMode>(
      value: value,
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }
}

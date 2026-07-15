import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/cubit/theme_cubit.dart';

/// Компактный переключатель темы — один [SwitchListTile] «Тёмная тема».
///
/// Дефолт первого запуска — [ThemeMode.system] (не трогаем хранилище): switch
/// отражает текущую системную тему. Тап переводит в явный light/dark. Так три
/// режима сведены к бинарному тумблеру, понятному пользователю.
class ThemeSwitcherTile extends StatelessWidget {
  const ThemeSwitcherTile({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeCubit>().state;
    final systemIsDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    // Switch включён, если тема тёмная явно или system при тёмной системе.
    final isDark = mode == ThemeMode.dark || (mode == ThemeMode.system && systemIsDark);

    return SwitchListTile(
      value: isDark,
      onChanged: (on) => context.read<ThemeCubit>().setMode(on ? ThemeMode.dark : ThemeMode.light),
      title: Text(LocaleKeys.themeDark.tr(), style: Theme.of(context).textTheme.bodyLarge),
      secondary: Icon(
        isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      activeThumbColor: Theme.of(context).colorScheme.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }
}

/// Компактная кнопка-иконка переключения темы (для шапок логина/приюта).
///
/// Та же бинарная логика, что и [ThemeSwitcherTile]: тап переводит между
/// явными light/dark, иконка отражает текущее состояние (с учётом system).
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeCubit>().state;
    final systemIsDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    final isDark = mode == ThemeMode.dark || (mode == ThemeMode.system && systemIsDark);

    return IconButton(
      tooltip: LocaleKeys.themeDark.tr(),
      icon: Icon(
        isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () => context.read<ThemeCubit>().setMode(isDark ? ThemeMode.light : ThemeMode.dark),
    );
  }
}

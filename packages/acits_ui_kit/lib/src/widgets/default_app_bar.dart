import 'package:flutter/material.dart';

/// Дефолтный AppBar.
///
/// Обёртка над [AppBar]: цвета фона/заголовка приходят из `AppBarTheme`
/// (M3-тема), поэтому App Bar автоматически следует за светлой/тёмной темой.
/// Цвет стрелки «назад» берётся из `colorScheme.primary`.
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key, required this.titleString, required this.onBackPressure, this.elevation});

  final String titleString;
  final VoidCallback onBackPressure;
  final double? elevation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleString),
      leading: GestureDetector(
        onTap: onBackPressure,
        child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
      ),
      centerTitle: true,
      elevation: elevation,
      shadowColor: Colors.transparent,
    );
  }
}

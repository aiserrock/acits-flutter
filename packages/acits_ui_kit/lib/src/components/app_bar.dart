import 'package:flutter/material.dart';

/// Обёртка над [AppBar]: цвета фона/заголовка приходят из `AppBarTheme` темы,
/// поэтому бар автоматически следует за светлой/тёмной темой. Стрелка «назад»
/// красится в `colorScheme.primary`.
class UiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UiAppBar({required this.title, this.onBack, this.actions, this.elevation, super.key});

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final double? elevation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: elevation,
      actions: actions,
      leading: onBack == null
          ? null
          : IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
              onPressed: onBack,
            ),
    );
  }
}

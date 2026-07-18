import 'package:flutter/material.dart';

import 'breakpoints.dart';

/// Пункт навигации адаптивного каркаса.
class AdaptiveDestination {
  const AdaptiveDestination({required this.icon, required this.label, this.selectedIcon});

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
}

/// Каркас, выбирающий форму навигации по ширине окна:
/// compact (<600) — нижний [NavigationBar]; medium (>=600) — свёрнутый
/// [NavigationRail]; expanded (>=840) — extended [NavigationRail]; large
/// (>=1200) — extended rail + двухпанельный режим ([secondaryPane]/[twoPane]).
///
/// Пересобирается на ресайзе: ширина читается через [MediaQuery.sizeOf].
class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    this.secondaryPane,
    this.twoPane = true,
    this.appBar,
    this.floatingActionButton,
    super.key,
  }) : assert(destinations.length >= 2);

  final List<AdaptiveDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  /// Основная область контента.
  final Widget body;

  /// Вторичная панель для large-режима (детали/инспектор). Показывается только
  /// при [twoPane] и ширине >= [Breakpoints.large].
  final Widget? secondaryPane;

  /// Разрешить двухпанельную раскладку на large. Если false — на large тоже
  /// показывается одна панель (шов остаётся, но не активируется).
  final bool twoPane;

  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final size = WindowSize.fromWidth(MediaQuery.sizeOf(context).width);

    if (size == WindowSize.compact) {
      return Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            for (final d in destinations)
              NavigationDestination(icon: d.icon, selectedIcon: d.selectedIcon, label: d.label),
          ],
        ),
      );
    }

    final extended = size == WindowSize.expanded || size == WindowSize.large;
    final rail = NavigationRail(
      extended: extended,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        for (final d in destinations)
          NavigationRailDestination(icon: d.icon, selectedIcon: d.selectedIcon ?? d.icon, label: Text(d.label)),
      ],
    );

    // На large при twoPane и наличии вторичной панели контент делится на две
    // колонки; LayoutBuilder даёт локальные размеры каждой панели.
    final showTwoPane = twoPane && size == WindowSize.large && secondaryPane != null;
    final content = showTwoPane
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  Expanded(flex: 2, child: body),
                  const VerticalDivider(width: 1.0),
                  Expanded(flex: 3, child: secondaryPane!),
                ],
              );
            },
          )
        : body;

    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          rail,
          const VerticalDivider(width: 1.0),
          Expanded(child: content),
        ],
      ),
    );
  }
}

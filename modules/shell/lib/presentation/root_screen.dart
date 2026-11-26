import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ui_kit/ui_kit.dart';

import 'package:shell/widget/personal_drawer.dart';
import 'package:shell/util/web_insets/web_insets.dart';

List<AdaptiveDestination> _buildDestinations(BuildContext context) {
  final inactive = context.appColors.inactiveIcon;
  final accent = Theme.of(context).colorScheme.primary;
  AdaptiveDestination item(SvgGenImage icon, String label, {bool enabled = true}) => AdaptiveDestination(
    icon: icon.svg(colorFilter: ColorFilter.mode(enabled ? inactive : inactive.withValues(alpha: .5), BlendMode.srcIn)),
    selectedIcon: icon.svg(colorFilter: ColorFilter.mode(accent, BlendMode.srcIn)),
    label: label,
    enabled: enabled,
  );
  return [
    item(Assets.icon.today, LocaleKeys.commonToday.tr()),
    item(Assets.icon.paw, LocaleKeys.commonAnimals.tr()),
    item(Assets.icon.calendar, LocaleKeys.commonCalendar.tr()),
    item(Assets.icon.drugs, LocaleKeys.commonDrugs.tr()),
  ];
}

/// The signed-in shell: navigation bar or rail around the four tabs.
///
/// Tabs are branches of a `StatefulShellRoute` (see `app_router.dart`): each has
/// its own URL (`/today`, `/animals`, `/calendar`, `/drugs`) and its own
/// navigation stack, kept while the user switches tabs. A branch is built the
/// first time it is opened.
class RootScreen extends StatefulWidget {
  const RootScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Отмена подписки на WebInsets (см. dispose).
  void Function()? _insetsSub;

  @override
  void initState() {
    super.initState();
    // safe-area (iOS PWA): библиотека меряет inset лениво — на первом кадре он
    // может быть 0. После первого кадра и на изменение (поворот) — пересобираем.
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
      _insetsSub = WebInsets.onChange(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _insetsSub?.call();
    super.dispose();
  }

  void _onDestinationSelected(int index) {
    final shell = widget.navigationShell;
    // A second tap on the current tab returns it to its root page.
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return RootDrawerProvider(
      rootScaffoldKey: _scaffoldKey,
      // Форму навигации выбирает ширина окна: нижняя панель на телефоне, рейл на
      // планшете, развёрнутый рейл на широком окне.
      child: AdaptiveScaffold(
        scaffoldKey: _scaffoldKey,
        drawer: const PersonalDrawerWidget(),
        destinations: _buildDestinations(context),
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        // Web (iOS PWA): Flutter не пробрасывает env(safe-area-inset) в MediaQuery,
        // поэтому нижняя панель лезла бы под home-indicator. На нативе inset = 0.
        bottomInset: kIsWeb ? WebInsets.bottom : 0,
        body: widget.navigationShell,
      ),
    );
  }
}

class RootDrawerProvider extends InheritedWidget {
  const RootDrawerProvider({required super.child, required this.rootScaffoldKey, super.key});

  final GlobalKey<ScaffoldState> rootScaffoldKey;

  static RootDrawerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RootDrawerProvider>();
  }

  @override
  bool updateShouldNotify(RootDrawerProvider oldWidget) {
    return true;
  }

  void openDrawer() {
    rootScaffoldKey.currentState?.openDrawer();
  }
}

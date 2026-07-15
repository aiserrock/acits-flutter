import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/res/theme.dart';
import 'package:acits_flutter/ui/screen/animals/animals_screen.dart';
import 'package:acits_flutter/ui/screen/calendar/calendar_screen.dart';
import 'package:acits_flutter/ui/screen/drugs/drugs_screen.dart';
import 'package:acits_flutter/ui/screen/main/main_screen.dart';
import 'package:acits_flutter/ui/widget/personal_drawer.dart';
import 'package:acits_flutter/util/web_insets/web_insets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

List<BottomNavigationBarItem> _buildBottomNavItems(BuildContext context) {
  final inactiveIcon = context.appColors.inactiveIcon;
  final accent = Theme.of(context).colorScheme.primary;
  return <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Assets.icon.today.svg(color: inactiveIcon),
      activeIcon: Assets.icon.today.svg(color: accent),
      label: LocaleKeys.commonToday.tr(),
    ),
    BottomNavigationBarItem(
      icon: Assets.icon.paw.svg(color: inactiveIcon),
      activeIcon: Assets.icon.paw.svg(color: accent),
      label: LocaleKeys.commonAnimals.tr(),
    ),
    BottomNavigationBarItem(
      icon: Assets.icon.calendar.svg(color: inactiveIcon.withValues(alpha: .5)),
      activeIcon: Assets.icon.calendar.svg(color: accent),
      label: LocaleKeys.commonCalendar.tr(),
    ),
    BottomNavigationBarItem(
      icon: Assets.icon.drugs.svg(color: inactiveIcon.withValues(alpha: .5)),
      activeIcon: Assets.icon.drugs.svg(color: accent),
      label: LocaleKeys.commonDrugs.tr(),
    ),
  ];
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;

  /// Индексы вкладок, которые уже были показаны хотя бы раз. Вкладку строим
  /// (и поднимаем её cubit) лениво — только после первого перехода на неё,
  /// а не все четыре с первого кадра. AnimalsScreen не грузит список, пока
  /// пользователь не откроет вкладку «Животные».
  final _visited = <int>{0};

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

  @override
  Widget build(BuildContext context) {
    final bottomNav = BottomNavigationBar(
      items: _buildBottomNavItems(context),
      onTap: (index) => setState(() {
        if (index > 1) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(content: Text(LocaleKeys.commonDidNotImpl.tr()), duration: const Duration(seconds: 2)),
            );
        }
        if (_current != index && index < 2) {
          _current = index;
          _visited.add(index);
        }
      }),
      currentIndex: _current,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      fixedColor: Theme.of(context).colorScheme.primary,
    );

    // Web (iOS PWA): Flutter не пробрасывает env(safe-area-inset) в MediaQuery,
    // поэтому нав-бар лезет под home-indicator. Берём реальный inset из JS-либы
    // (WebInsets) и заставляем SafeArea дать минимум этого отступа. На нативе
    // WebInsets.bottom = 0, и обёртку не ставим — Scaffold сам учитывает inset.
    final bottomNavWithInset = kIsWeb
        ? SafeArea(
            minimum: EdgeInsets.only(bottom: WebInsets.bottom),
            child: bottomNav,
          )
        : bottomNav;

    return RootDrawerProvider(
      rootScaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const PersonalDrawerWidget(),
        bottomNavigationBar: bottomNavWithInset,
        // IndexedStack сохраняет состояние уже открытых вкладок (скролл,
        // введённый поиск), но каждую вкладку строим лениво — до первого
        // перехода на неё в дереве стоит пустой SizedBox, и её cubit не
        // поднимается. Calendar/Drugs пока недостижимы (см. onTap: index<2),
        // поэтому остаются заглушками навсегда, не тратя ресурсы.
        body: IndexedStack(
          index: _current,
          children: [
            _visited.contains(0) ? const MainScreen() : const SizedBox.shrink(),
            _visited.contains(1) ? const AnimalsScreen() : const SizedBox.shrink(),
            const CalendarScreen(),
            const DrugsScreen(),
          ],
        ),
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

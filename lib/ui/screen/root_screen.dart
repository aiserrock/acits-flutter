import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/ui/screen/animals/animals_screen.dart';
import 'package:acits_flutter/ui/screen/calendar/calendar_screen.dart';
import 'package:acits_flutter/ui/screen/drugs/drugs_screen.dart';
import 'package:acits_flutter/ui/screen/main/main_screen.dart';
import 'package:acits_flutter/ui/widget/personal_drawer.dart';
import 'package:acits_flutter/util/web_insets/web_insets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

final _bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Assets.icon.today.svg(color: ColorRes.inactiveIcon),
    activeIcon: Assets.icon.today.svg(color: ColorRes.accent),
    label: LocaleKeys.commonToday.tr(),
  ),
  BottomNavigationBarItem(
    icon: Assets.icon.paw.svg(color: ColorRes.inactiveIcon),
    activeIcon: Assets.icon.paw.svg(color: ColorRes.accent),
    label: LocaleKeys.commonAnimals.tr(),
  ),
  BottomNavigationBarItem(
    icon: Assets.icon.calendar.svg(color: ColorRes.inactiveIcon.withValues(alpha: .5)),
    activeIcon: Assets.icon.calendar.svg(color: ColorRes.accent),
    label: LocaleKeys.commonCalendar.tr(),
  ),
  BottomNavigationBarItem(
    icon: Assets.icon.drugs.svg(color: ColorRes.inactiveIcon.withValues(alpha: .5)),
    activeIcon: Assets.icon.drugs.svg(color: ColorRes.accent),
    label: LocaleKeys.commonDrugs.tr(),
  ),
];

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;

  @override
  void initState() {
    super.initState();
    // safe-area (iOS PWA): библиотека меряет inset лениво — на первом кадре он
    // может быть 0. После первого кадра и на изменение (поворот) — пересобираем.
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
      WebInsets.onChange(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomNav = BottomNavigationBar(
      items: _bottomNavItems,
      onTap: (index) => setState(() {
        if (index > 1) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(LocaleKeys.commonDidNotImpl.tr()),
                duration: const Duration(seconds: 2),
              ),
            );
        }
        if (_current != index && index < 2) _current = index;
      }),
      currentIndex: _current,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      fixedColor: ColorRes.accent,
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
        body: Stack(
          children: [
            Offstage(offstage: _current != 0, child: const MainScreen()),
            Offstage(offstage: _current != 1, child: const AnimalsScreen()),
            Offstage(offstage: _current != 2, child: const CalendarScreen()),
            Offstage(offstage: _current != 3, child: const DrugsScreen()),
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

import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/ui/screen/animals/animals_screen.dart';
import 'package:acits_flutter/ui/screen/calendar/calendar_screen.dart';
import 'package:acits_flutter/ui/screen/drugs/drugs_screen.dart';
import 'package:acits_flutter/ui/screen/main/main_screen.dart';
import 'package:flutter/material.dart';

final _bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Assets.icon.today.svg(
      color: ColorRes.inactiveIcon,
    ),
    activeIcon: Assets.icon.today.svg(
      color: ColorRes.accent,
    ),
    label: StringRes.current.commonToday,
  ),
  BottomNavigationBarItem(
    icon: Assets.icon.paw.svg(
      color: ColorRes.inactiveIcon,
    ),
    activeIcon: Assets.icon.paw.svg(
      color: ColorRes.accent,
    ),
    label: StringRes.current.commonAnimals,
  ),
  BottomNavigationBarItem(
    icon: Assets.icon.calendar.svg(
      color: ColorRes.inactiveIcon.withOpacity(.5),
    ),
    activeIcon: Assets.icon.calendar.svg(
      color: ColorRes.accent,
    ),
    label: StringRes.current.commonCalendar,
  ),
  BottomNavigationBarItem(
    icon: Assets.icon.drugs.svg(
      color: ColorRes.inactiveIcon.withOpacity(.5),
    ),
    activeIcon: Assets.icon.drugs.svg(
      color: ColorRes.accent,
    ),
    label: StringRes.current.commonDrugs,
  ),
];

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavItems,
        onTap: (index) => setState(
          () {
            if (index > 1) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text(StringRes.current.commonDidNotImpl),
                    duration: const Duration(seconds: 2),
                  ),
                );
            }
            if (_current != index && index < 2) _current = index;
          },
        ),
        currentIndex: _current,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        fixedColor: ColorRes.accent,
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _current != 0,
            child: const MainScreen(),
          ),
          Offstage(
            offstage: _current != 1,
            child: const AnimalsScreen(),
          ),
          Offstage(
            offstage: _current != 2,
            child: const CalendarScreen(),
          ),
          Offstage(
            offstage: _current != 3,
            child: const DrugsScreen(),
          ),
        ],
      ),
    );
  }
}

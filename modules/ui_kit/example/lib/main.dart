import 'package:example/page/adaptive_scaffold.dart';
import 'package:example/page/app_bar.dart';
import 'package:example/page/bottom_sheet.dart';
import 'package:example/page/buttons.dart';
import 'package:example/page/chip.dart';
import 'package:example/page/colors.dart';
import 'package:example/page/form_card.dart';
import 'package:example/page/holders.dart';
import 'package:example/page/icons.dart';
import 'package:example/page/images.dart';
import 'package:example/page/loaders.dart';
import 'package:example/page/lottie.dart';
import 'package:example/page/misc.dart';
import 'package:example/page/sort_chips.dart';
import 'package:example/page/text_field.dart';
import 'package:example/page/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:ui_kit/ui_kit.dart';

void main() => runApp(const UiKitStorybookApp());

/// Standalone storybook для дизайн-системы ACITS (ui_kit).
///
/// Одна страница на компонент/раздел (`page/*.dart`); панельный плагин
/// theme-mode переключает light/dark через `MediaQuery`, а [_wrapper] оборачивает
/// каждую историю в реальную [AppTheme], чтобы всё рендерилось на продовых
/// токенах.
class UiKitStorybookApp extends StatelessWidget {
  const UiKitStorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(wrapperBuilder: _wrapper, stories: _stories);
  }
}

/// `MaterialApp` с продовой [AppTheme] и делегатами локализации (нужны
/// Material-виджетам вроде date picker). Плагин theme-mode переопределяет
/// platform brightness через `MediaQuery`, поэтому тумблер на панели управляет
/// light/dark.
Widget _wrapper(BuildContext context, Widget? child) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [Locale('ru'), Locale('en')],
  home: child,
);

final _stories = <Story>[
  // Foundations
  Story(name: 'Foundations/Colors', builder: (_) => const ColorsPage()),
  Story(name: 'Foundations/Typography', builder: (_) => const TypographyPage()),
  Story(name: 'Foundations/Icons', builder: (_) => const IconsPage()),
  Story(name: 'Foundations/Images', builder: (_) => const ImagesPage()),
  Story(name: 'Foundations/Lottie', builder: (_) => const LottiePage()),
  // Components
  Story(name: 'Components/Buttons', builder: (_) => const ButtonsPage()),
  Story(name: 'Components/TextField', builder: (_) => const TextFieldPage()),
  Story(name: 'Components/Chip', builder: (_) => const ChipPage()),
  Story(name: 'Components/AppBar', builder: (_) => const AppBarPage()),
  Story(name: 'Components/BottomSheet', builder: (_) => const BottomSheetPage()),
  Story(name: 'Components/Loaders', builder: (_) => const LoadersPage()),
  Story(name: 'Components/Holders', builder: (_) => const HoldersPage()),
  Story(name: 'Components/SortChipsBar', builder: (_) => const SortChipsPage()),
  Story(name: 'Components/FormEditCard', builder: (_) => const FormCardPage()),
  Story(name: 'Components/Misc', builder: (_) => const MiscPage()),
  // Layout
  Story(name: 'Layout/AdaptiveScaffold', builder: (_) => const AdaptiveScaffoldPage()),
];

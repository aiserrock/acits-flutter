import 'package:animals/animals.dart';
import 'package:prescriptions/prescriptions.dart' show DrugsScreen;
import 'package:personal/personal.dart' show CalendarScreen;

import 'package:di/di.dart';
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:shell/presentation/main/main_screen.dart';
import 'package:shell/widget/personal_drawer.dart';
import 'package:shell/util/web_insets/web_insets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:material_ui/material_ui.dart';
import 'package:easy_localization/easy_localization.dart';

/// Индекс первой недоступной вкладки: «Календарь» и «Медикаменты» пока заглушки.
const _firstLockedTab = 2;

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
    item(Assets.icon.calendar, LocaleKeys.commonCalendar.tr(), enabled: false),
    item(Assets.icon.drugs, LocaleKeys.commonDrugs.tr(), enabled: false),
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
  /// а не все четыре с первого кадра. AnimalsPage не грузит список, пока
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

  /// Собрать мигрированный экран списка животных (модуль `animals`), прокинув
  /// зависимости из DI, drawer приложения и app-ассеты (заглушки/иллюстрации),
  /// которыми модуль не владеет.
  Widget _buildAnimalsPage(BuildContext context) {
    return AnimalsPage(
      repository: getIt<AnimalRepository>(),
      shelterProvider: getIt<CurrentShelterProvider>(),
      router: getIt<AnimalsRouterService>(),
      permissions: getIt<AnimalPermissions>(),
      statusLabels: getIt<AnimalStatusLabels>(),
      onMenuPressed: RootDrawerProvider.of(context)?.openDrawer,
      emptyStateIllustration: Assets.common.emptyState.svg(),
      avatarFallback: Assets.image.animalStub.image(fit: BoxFit.cover, width: 80.0, height: 80.0),
    );
  }

  void _onDestinationSelected(int index) {
    if (index >= _firstLockedTab || index == _current) return;
    setState(() {
      _current = index;
      _visited.add(index);
    });
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
        selectedIndex: _current,
        onDestinationSelected: _onDestinationSelected,
        // Web (iOS PWA): Flutter не пробрасывает env(safe-area-inset) в MediaQuery,
        // поэтому нижняя панель лезла бы под home-indicator. На нативе inset = 0.
        bottomInset: kIsWeb ? WebInsets.bottom : 0,
        // IndexedStack сохраняет состояние уже открытых вкладок (скролл,
        // введённый поиск), но каждую вкладку строим лениво — до первого
        // перехода на неё в дереве стоит пустой SizedBox, и её cubit не
        // поднимается. Calendar/Drugs пока недоступны, поэтому остаются заглушками.
        body: IndexedStack(
          index: _current,
          children: [
            _visited.contains(0) ? const MainScreen() : const SizedBox.shrink(),
            _visited.contains(1) ? _buildAnimalsPage(context) : const SizedBox.shrink(),
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

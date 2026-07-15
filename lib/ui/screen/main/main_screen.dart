import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/ui/screen/root_screen.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/ui/screen/common/sort/sort_chips_bar.dart';
import 'package:acits_flutter/ui/screen/common/sort/sort_preset.dart';
import 'package:acits_flutter/ui/screen/main/cubit/main_cubit.dart';
import 'package:acits_flutter/ui/screen/main/cubit/main_state.dart';
import 'package:acits_flutter/ui/widget/screen_loader.dart';
import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/ui/widget/prescription_card.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/res/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => MainCubit(), child: const _MainView());
  }
}

class _MainView extends StatefulWidget {
  const _MainView();

  @override
  State<_MainView> createState() => _MainViewState();
}

class _MainViewState extends State<_MainView> {
  _MainViewState() : _debugService = getIt.get<DebugService>();

  final DebugService _debugService;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  late bool _isSmallScreen;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isSmallScreen = MediaQuery.of(context).size.width <= 340.0;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChange);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChange);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChange() {
    context.read<MainCubit>().onSearchChanged(_searchController.text);
  }

  /// Выйти из режима поиска: очистить поле без повторного запроса и переключить
  /// режим — cubit сам перезагрузит список без фильтра.
  void _exitSearch() {
    _searchController.removeListener(_onSearchChange);
    _searchController.clear();
    _searchController.addListener(_onSearchChange);
    context.read<MainCubit>().toggleSearch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shadowColor: Colors.transparent,
            leading: state.isSearchActive
                ? GestureDetector(
                    onTap: _exitSearch,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: RootDrawerProvider.of(context)?.openDrawer,
                        onLongPress: () => _openDebug(context),
                        child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary),
                      );
                    },
                  ),
            title: _buildTitle(state),
            actions: _buildAppBarActions(state),
            centerTitle: true,
          ),
          floatingActionButton: _buidFab(context),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buidFab(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'MainFab',
      mini: _isSmallScreen,
      onPressed: () => _onFabPressed(context),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  List<Widget> _buildAppBarActions(MainState state) {
    return [
      if (!state.isSearchActive)
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
            onTap: () => context.read<MainCubit>().toggleSearch(),
          ),
        ),
    ];
  }

  Widget _buildBody(MainState state) {
    return Column(
      children: [
        SortChipsBar(
          presets: kTodaySortPresets,
          activeId: state.activeSort.id,
          onSelected: (preset) => context.read<MainCubit>().onSortChanged(preset),
        ),
        Expanded(
          child: DataStateBuilder<PaginatedPrescriptionExecutionTodayList?>(
            state: state.data,
            loader: (_) => const ScreenLoader(height: 104.0),
            builder: (_, data) => _MainScreenContent(
              data,
              isSearching: state.searchRequest.isNotEmpty,
              pullToRefresh: context.read<MainCubit>().loadExecutions,
            ),
            errorBuilder: (_, _) => Column(),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(MainState state) {
    return state.isSearchActive
        ? SizedBox(
            height: 40.0,
            child: TextField(
              autofocus: true,
              controller: _searchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                hintText: LocaleKeys.commonSearch.tr(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                suffixIcon: GestureDetector(
                  onTap: _searchController.clear,
                  child: Icon(
                    Icons.close,
                    size: 18.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(minWidth: 36.0, minHeight: 40.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          )
        : Text(
            LocaleKeys.mainTitle.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          );
  }

  void _openDebug(BuildContext context) {
    _debugService.openDebugScreen();
  }

  void _onFabPressed(BuildContext context) {
    final cubit = context.read<MainCubit>();
    context.push<Prescription>(AppRoutes.prescriptionEdit).then((value) {
      if (value != null) cubit.loadExecutions();
    });
  }
}

class _MainScreenContent extends StatelessWidget {
  const _MainScreenContent(this.data, {required this.isSearching, required this.pullToRefresh});

  final PaginatedPrescriptionExecutionTodayList? data;
  final bool isSearching;
  final Future<void> Function() pullToRefresh;

  @override
  Widget build(BuildContext context) {
    return (data?.results?.isEmpty ?? true) ? _buildEmptyState(context) : _buildList();
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: pullToRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 40.0),
        itemBuilder: (_, index) {
          final item = (data?.results ?? [])[index];
          return PrescriptionCardWidget(
            item,
            onEditedPrescription: () => _onEditPrescriptionPressed(item),
          );
        },
        itemCount: data?.results?.length ?? 0,
        separatorBuilder: (_, _) => const SizedBox(height: 16.0),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return LayoutBuilder(
      builder: (_, cons) {
        return RefreshIndicator(
          onRefresh: pullToRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: cons.maxHeight,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Assets.common.emptyState.svg()],
                    ),
                    Text(
                      isSearching ? LocaleKeys.commonNotFound.tr() : LocaleKeys.mainEmptyState.tr(),
                      style: TextStyle(fontSize: 16.0, color: context.appColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onEditPrescriptionPressed(PrescriptionExecutionToday item) async {
    final result = await getIt<GoRouter>().push<Prescription>(
      "${AppRoutes.prescriptionEdit}?id=${item.prescription.id}",
    );
    if (result != null) await pullToRefresh();
  }
}

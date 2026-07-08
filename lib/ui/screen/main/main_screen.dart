import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/ui/screen/root_screen.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/ui/screen/main/cubit/main_cubit.dart';
import 'package:acits_flutter/ui/widget/screen_loader.dart';
import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/ui/widget/prescription_card.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/gen/l10n/locale_keys.g.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';
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
  bool _isSearchActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isSmallScreen = MediaQuery.of(context).size.width <= 340.0;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: RootDrawerProvider.of(context)?.openDrawer,
              onLongPress: () => _openDebug(context),
              child: const Icon(Icons.menu, color: ColorRes.accent),
            );
          },
        ),
        title: _buildTitle(),
        actions: _buildAppBarActions,
        centerTitle: true,
      ),
      floatingActionButton: _buidFab(context),
      body: _buildBody(),
    );
  }

  Widget _buidFab(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'MainFab',
      mini: _isSmallScreen,
      onPressed: () => _onFabPressed(context),
      backgroundColor: ColorRes.accent,
      child: const Icon(Icons.add, color: ColorRes.foreground),
    );
  }

  List<Widget> get _buildAppBarActions {
    return [
      if (!_isSearchActive)
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: const Icon(Icons.search, color: ColorRes.accent),
            onTap: () => setState(() => _isSearchActive = !_isSearchActive),
          ),
        ),
    ];
  }

  Widget _buildBody() {
    return BlocBuilder<MainCubit, DataState<PaginatedPrescriptionExecutionTodayList?>>(
      builder: (context, state) {
        return DataStateBuilder<PaginatedPrescriptionExecutionTodayList?>(
          state: state,
          loader: (_) => const ScreenLoader(height: 104.0),
          builder: (_, data) =>
              _MainScreenContent(data, pullToRefresh: context.read<MainCubit>().loadExecutions),
          errorBuilder: (_, _) => Column(),
        );
      },
    );
  }

  Widget _buildTitle() {
    return _isSearchActive
        ? SizedBox(
            height: 40.0,
            child: TextField(
              autofocus: true,
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 16.0, right: 8.0),
                suffix: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Assets.icon.close.svg(height: 16.0, width: 16.0, color: ColorRes.accent),
                  ),
                  onTap: () => setState(() => _isSearchActive = !_isSearchActive),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
              style: StyleRes.content.copyWith(color: ColorRes.textPrimary),
            ),
          )
        : Text(LocaleKeys.mainTitle.tr(), style: const TextStyle(color: ColorRes.textPrimary));
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
  const _MainScreenContent(this.data, {required this.pullToRefresh});

  final PaginatedPrescriptionExecutionTodayList? data;
  final Future<void> Function() pullToRefresh;

  @override
  Widget build(BuildContext context) {
    return (data?.results?.isEmpty ?? true) ? _buildEmptyState() : _buildList();
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

  Widget _buildEmptyState() {
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
                      LocaleKeys.mainEmptyState.tr(),
                      style: const TextStyle(fontSize: 16.0, color: ColorRes.textSecondary),
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
      "${AppRoutes.prescriptionEdit}?id=${item.prescription?.id}",
    );
    if (result != null) await pullToRefresh();
  }
}

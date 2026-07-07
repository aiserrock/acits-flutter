import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/ui/screen/root_screen.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:acits_flutter/ui/widget/screen_loader.dart';
import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/ui/widget/prescription_card.dart';
import 'package:acits_flutter/util/screen_state.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState()
    : _prescriptionService = getIt.get<PrescriptionService>(),
      _debugService = getIt.get<DebugService>();

  final PrescriptionService _prescriptionService;
  final DebugService _debugService;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool _isSmallScreen;
  bool _isSearchActive = false;

  ScreenDataState<PaginatedPrescriptionExecutionTodayList?> _state = ScreenDataState()..loading();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isSmallScreen = MediaQuery.of(context).size.width <= 340.0;
  }

  @override
  void initState() {
    super.initState();
    _loadExecutions();
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
    return StateBuilder<PaginatedPrescriptionExecutionTodayList?>(
      state: _state,
      loader: (_) => const ScreenLoader(height: 104.0),
      builder: (_, data) => _MainScreenContent(data, pullToRefresh: _loadExecutions),
      errorBuilder: (_, error) => Column(),
    );
  }

  Widget _buildTitle() {
    return _isSearchActive
        ? SizedBox(
            height: 40.0,
            child: TextField(
              autofocus: true,
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
        : Text(StringRes.current.mainTitle, style: const TextStyle(color: ColorRes.textPrimary));
  }

  Future<void> _loadExecutions() async {
    setState(() => _state = ScreenDataState()..loading());
    await _prescriptionService
        .fetchTodayPrescriptionList()
        .then((value) => setState(() => _state = ScreenDataState()..content(value)))
        .catchError((e) => _state = ScreenDataState()..error = e);
  }

  void _openDebug(BuildContext context) {
    _debugService.openDebugScreen();
  }

  void _onFabPressed(BuildContext context) {
    context.push<Prescription>(AppRoutes.prescriptionEdit).then((value) {
      if (value != null) _loadExecutions();
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
                      StringRes.current.mainEmptyState,
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

  void _onEditPrescriptionPressed(PrescriptionExecutionToday item) {
    getIt<GoRouter>().push("${AppRoutes.prescriptionEdit}?id=${item.prescription?.id}");
  }
}

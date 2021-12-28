import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool _isSmallScreen;
  bool _isSearchActive = false;

  ScreenState<PaginatedPrescriptionExecutionTodayList?> _state = ScreenState()..loading();

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
      drawer: _buildDrawer(),
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(
            Icons.menu,
            color: ColorRes.accent,
          ),
          onTap: () => scaffoldKey.currentState?.openDrawer(),
        ),
        title: _buildTitle(),
        actions: _buildAppBarActions,
        centerTitle: true,
      ),
      floatingActionButton: _buidFab(),
      body: _buildBody(),
    );
  }

  Widget _buidFab() {
    return FloatingActionButton(
      mini: _isSmallScreen,
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: ColorRes.foreground,
      ),
      backgroundColor: ColorRes.accent,
    );
  }

  List<Widget> get _buildAppBarActions {
    return [
      if (!_isSearchActive)
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: const Icon(
              Icons.search,
              color: ColorRes.accent,
            ),
            onTap: () => setState(() => _isSearchActive = !_isSearchActive),
          ),
        ),
    ];
  }

  Widget _buildBody() {
    return ScreenStateBuilder<PaginatedPrescriptionExecutionTodayList?>(
      state: _state,
      loader: (_) => const _MainScreenLoader(),
      builder: (_, data) => _MainScreenContent(
        data,
        typeNameMapper: getIt<PrescriptionService>().getTypeName,
        pullToRefresh: _loadExecutions,
      ),
      errorBuilder: (_, error) => Column(),
    );
  }

  Widget _buildDrawer() => const Drawer();

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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              style: StyleRes.content.copyWith(color: ColorRes.textPrimary),
            ),
          )
        : Text(
            StringRes.current.mainTitle,
            style: const TextStyle(color: ColorRes.textPrimary),
          );
  }

  Future<void> _loadExecutions() async {
    setState(() => _state = ScreenState()..loading());
    final service = getIt<PrescriptionService>();
    await service
        .getTodayPrescriptionList()
        .then((value) => setState(() => _state = ScreenState()..content(value)))
        .catchError((e) => _state = ScreenState()..error = e);
  }
}

class _MainScreenContent extends StatelessWidget {
  const _MainScreenContent(
    this.data, {
    required this.typeNameMapper,
    required this.pullToRefresh,
    Key? key,
  }) : super(key: key);

  final PaginatedPrescriptionExecutionTodayList? data;
  final String? Function(MyTypeEnum?) typeNameMapper;
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
        itemBuilder: (_, index) => PrescriptionCardWidget(
          (data?.results ?? [])[index],
          typeNameMapper: typeNameMapper,
        ),
        itemCount: data?.results?.length ?? 0,
        separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: pullToRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Assets.common.emptyState.svg()],
              ),
              Text(
                StringRes.current.mainEmptyState,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: ColorRes.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainScreenLoader extends StatelessWidget {
  const _MainScreenLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 40.0),
        child: Column(
          children: List.filled(
            4,
            Shimmer.fromColors(
              child: Container(
                height: 108.0,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: const BoxDecoration(
                  color: ColorRes.textSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              baseColor: ColorRes.inactiveIcon.withOpacity(.3),
              highlightColor: ColorRes.background,
            ),
          ),
        ),
      ),
    );
  }
}

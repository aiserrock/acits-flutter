import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/animal_edit_screen.dart';
import 'package:acits_flutter/ui/widget/animal_card.dart';
import 'package:acits_flutter/ui/widget/personal_drawer.dart';
import 'package:acits_flutter/ui/widget/screen_loader.dart';
import 'package:acits_flutter/util/screen_state.dart';
import 'package:flutter/material.dart';
import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const _animalPageLength = 25;
const _scrollTopPadding = 16.0;

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({Key? key}) : super(key: key);

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  late bool _isSmallScreen;
  bool _isSearchActive = false;
  int _currentListOffset = 0;

  WidgetState<List<AnimalRead>?> _state = WidgetState()..loading();
  WidgetState<Object> _statePageLoading = WidgetState()..content(Object());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isSmallScreen = MediaQuery.of(context).size.width <= 340.0;
    _scrollController.addListener(_onScroll);
  }

  @override
  void initState() {
    super.initState();
    _loadAnimalList(needResetOffset: true);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
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
      heroTag: 'AnimalsFab',
      mini: _isSmallScreen,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const AnimalEditScreen(),
        ),
      ),
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
    return StateBuilder<List<AnimalRead>?>(
      state: _state,
      loader: (_) => ScreenLoader(
        height: 160.0,
        pullToRefresh: () => _loadAnimalList(needResetOffset: true),
      ),
      builder: (_, data) => _buildScreenContent(),
      errorBuilder: (_, error) => Column(),
    );
  }

  Widget _buildDrawer() => const PersonalDrawerWidget();

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
            StringRes.current.commonAnimals,
            style: const TextStyle(color: ColorRes.textPrimary),
          );
  }

  Widget _buildScreenContent() {
    return (_state.value?.isEmpty ?? true) ? _buildEmptyState() : _buildList();
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: () => _loadAnimalList(needResetOffset: true),
      child: SlidableAutoCloseBehavior(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: _scrollController,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: _scrollTopPadding)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: AnimalCardWidget(_state.value?[index]),
                ),
                childCount: _state.value?.length ?? 0,
              ),
            ),
            SliverToBoxAdapter(
              child: StateBuilder(
                state: _statePageLoading,
                builder: (_, __) => const SizedBox(height: 16.0),
                loader: (_) => const SizedBox(
                  height: 48.0,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorBuilder: (_, __) => SizedBox(
                  height: 64.0,
                  child: Center(child: Text(StringRes.current.commonError)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () => _loadAnimalList(needResetOffset: true),
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

  void _onScroll() {
    final positions = _scrollController.position;
    if (positions.pixels >= positions.maxScrollExtent) _loadNextPage();
  }

  void _loadNextPage() {
    if (_statePageLoading.isLoading) return;
    setState(() => _statePageLoading = WidgetState()..loading());
    _loadAnimalList();
  }

  Future<List<AnimalRead>?> _loadAnimalList({bool needResetOffset = false}) async {
    if (needResetOffset) {
      _currentListOffset = 0;
      setState(() => _state = WidgetState()..loading());
    }
    final _service = getIt<AnimalService>();
    await _service
        .fetchAnimalList(
      offset: _currentListOffset,
      limit: _animalPageLength,
    )
        .then(
      (value) {
        final newList = <AnimalRead>[
          ...?_state.value,
          ...?value?.results,
        ];
        setState(() => _state = WidgetState()..content(newList));
        _currentListOffset += value?.results?.length ?? 0;
        setState(() => _statePageLoading = WidgetState()..content(Object()));
      },
    ).catchError(
      (e) {
        if (needResetOffset) {
          setState(() => _state = WidgetState()..error = e);
        } else {
          setState(() => _statePageLoading = WidgetState()..error = e);
        }
      },
    );
  }
}

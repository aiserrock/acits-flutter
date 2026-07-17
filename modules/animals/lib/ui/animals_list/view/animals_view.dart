import 'package:acits_core/acits_core.dart';
import 'package:acits_ui_kit/acits_ui_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../domain/animal_list_item.dart';
import '../../../domain/port/animal_permissions.dart';
import '../../../domain/port/animal_status_labels.dart';
import '../../../domain/router/animals_router_service.dart';
import '../animal_sort_presets.dart';
import '../animals_l10n_keys.dart';
import '../bloc/animals_cubit.dart';
import '../bloc/animals_state.dart';
import '../widgets/animal_card.dart';

const _scrollTopPadding = 16.0;

/// Экран списка животных (StatefulWidget с scroll/search-контроллерами).
/// Cubit поднимается родителем (AnimalsPage) через BlocProvider.
class AnimalsView extends StatefulWidget {
  const AnimalsView({
    required this.router,
    required this.permissions,
    required this.statusLabels,
    this.onMenuPressed,
    this.emptyStateIllustration,
    this.avatarFallback,
    super.key,
  });

  final AnimalsRouterService router;
  final AnimalPermissions permissions;
  final AnimalStatusLabels statusLabels;

  /// Открыть корневой drawer (app-level). null → кнопка-меню ничего не делает.
  final VoidCallback? onMenuPressed;

  /// Иллюстрация пустого состояния (SVG приложения передаёт корень).
  final Widget? emptyStateIllustration;

  /// Заглушка аватара карточки (ассет приложения).
  final Widget? avatarFallback;

  @override
  State<AnimalsView> createState() => _AnimalsViewState();
}

class _AnimalsViewState extends State<AnimalsView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
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
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChange);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.removeListener(_onSearchChange);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChange() {
    context.read<AnimalsCubit>().onSearchChanged(_searchController.text);
  }

  /// Выйти из режима поиска: очистить поле без повторного запроса
  /// (снимаем listener на время clear) и переключить режим — cubit сам
  /// перезагрузит список без фильтра.
  void _exitSearch() {
    _searchController.removeListener(_onSearchChange);
    _searchController.clear();
    _searchController.addListener(_onSearchChange);
    context.read<AnimalsCubit>().toggleSearch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimalsCubit, AnimalsState>(
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
                    child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.primary),
                  )
                : GestureDetector(
                    onTap: widget.onMenuPressed,
                    child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary),
                  ),
            title: _buildTitle(state),
            actions: _buildAppBarActions(state),
            centerTitle: true,
          ),
          floatingActionButton: _buildFab(),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      heroTag: 'AnimalsFab',
      mini: _isSmallScreen,
      onPressed: () async {
        final cubit = context.read<AnimalsCubit>();
        final isAdded = await widget.router.openCreate();
        if (isAdded ?? false) cubit.loadAnimalList(needResetOffset: true);
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  List<Widget> _buildAppBarActions(AnimalsState state) {
    return [
      if (!state.isSearchActive)
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
            onTap: () => context.read<AnimalsCubit>().toggleSearch(),
          ),
        ),
    ];
  }

  Widget _buildBody(AnimalsState state) {
    return Column(
      children: [
        SortChipsBar(
          presets: kAnimalSortPresets,
          activeId: state.activeSort.id,
          labelKey: AnimalsL10nKeys.commonSort,
          onSelected: (preset) => context.read<AnimalsCubit>().onSortChanged(preset),
        ),
        Expanded(
          child: DataStateBuilder<List<AnimalListItem>>(
            state: state.data,
            loader: (_) =>
                _ScreenLoader(pullToRefresh: () => context.read<AnimalsCubit>().loadAnimalList(needResetOffset: true)),
            builder: (_, data) => _buildScreenContent(state, data),
            errorBuilder: (_, _) => Column(),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(AnimalsState state) {
    return state.isSearchActive
        ? SizedBox(
            height: 40.0,
            child: TextField(
              autofocus: true,
              controller: _searchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                hintText: AnimalsL10nKeys.commonSearch.tr(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                prefixIcon: Icon(Icons.search, size: 20.0, color: Theme.of(context).colorScheme.primary),
                prefixIconConstraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                suffixIcon: GestureDetector(
                  onTap: _searchController.clear,
                  child: Icon(Icons.close, size: 18.0, color: Theme.of(context).colorScheme.primary),
                ),
                suffixIconConstraints: const BoxConstraints(minWidth: 36.0, minHeight: 40.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          )
        : Text(AnimalsL10nKeys.commonAnimals.tr(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface));
  }

  Widget _buildScreenContent(AnimalsState state, List<AnimalListItem> data) {
    return data.isEmpty ? _buildEmptyState(state) : _buildList(state, data);
  }

  Widget _buildList(AnimalsState state, List<AnimalListItem> data) {
    return RefreshIndicator(
      onRefresh: () => context.read<AnimalsCubit>().loadAnimalList(needResetOffset: true),
      child: SlidableAutoCloseBehavior(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: _scrollController,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: _scrollTopPadding)),
            SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
                final animal = data[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: AnimalCardWidget(
                    animal,
                    router: widget.router,
                    permissions: widget.permissions,
                    statusLabels: widget.statusLabels,
                    avatarFallback: widget.avatarFallback,
                    onDelete: () => _onDelete(context, animal),
                  ),
                );
              }, childCount: data.length),
            ),
            SliverToBoxAdapter(child: _buildPageLoader(state)),
          ],
        ),
      ),
    );
  }

  Widget _buildPageLoader(AnimalsState state) {
    return DataStateBuilder<int>(
      state: state.page,
      builder: (_, _) => const SizedBox(height: 16.0),
      loader: (_) => const SizedBox(height: 48.0, child: Center(child: CircularProgressIndicator())),
      errorBuilder: (_, _) => SizedBox(height: 64.0, child: Center(child: Text(AnimalsL10nKeys.commonError.tr()))),
    );
  }

  Widget _buildEmptyState(AnimalsState state) {
    // При активном поиске пустой список = «ничего не найдено», а не «нет животных».
    final message = state.searchRequest.isNotEmpty
        ? AnimalsL10nKeys.commonNotFound.tr()
        : AnimalsL10nKeys.animalsEmptyState.tr();
    return RefreshIndicator(
      onRefresh: () => context.read<AnimalsCubit>().loadAnimalList(needResetOffset: true),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (widget.emptyStateIllustration != null)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [widget.emptyStateIllustration!]),
              Text(message, style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.bodyMedium?.color)),
            ],
          ),
        ),
      ),
    );
  }

  void _onScroll() {
    final positions = _scrollController.position;
    if (positions.pixels >= positions.maxScrollExtent) {
      context.read<AnimalsCubit>().loadNextPage();
    }
  }

  Future<void> _onDelete(BuildContext context, AnimalListItem item) async {
    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<AnimalsCubit>().deleteAnimal(item);
    if (!success) {
      messenger.showSnackBar(SnackBar(content: Text(AnimalsL10nKeys.errorDefaultMsg.tr())));
    }
  }
}

/// Скелетон-лоадер списка (перенос из app `ScreenLoader`, на ui_kit `Skeleton`).
class _ScreenLoader extends StatelessWidget {
  const _ScreenLoader({this.pullToRefresh});

  final Future<void> Function()? pullToRefresh;

  @override
  Widget build(BuildContext context) {
    final list = _buildList(context);
    return pullToRefresh != null ? RefreshIndicator(onRefresh: pullToRefresh!, child: list) : list;
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 40.0),
        child: Column(
          children: List.filled(
            3,
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              margin: const EdgeInsets.only(bottom: 16.0),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(height: 20.0, width: 80.0),
                    SizedBox(height: 10.0),
                    Skeleton(height: 20.0, width: 170.0),
                    SizedBox(height: 10.0),
                    Skeleton(height: 20.0, width: double.infinity),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

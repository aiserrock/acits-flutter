import 'package:util/util.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:localization/localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/presentation/drugs/cubit/cubit.dart';
import 'package:prescriptions/presentation/drugs/widgets/drug_card.dart';

/// Экран «Медикаменты» (read-only каталог). Cubit поднимает родитель
/// ([DrugsScreen]) через BlocProvider.
class DrugsView extends StatefulWidget {
  const DrugsView({this.onMenuPressed, super.key});

  /// Открыть корневой drawer. null — кнопка-меню ничего не делает.
  final VoidCallback? onMenuPressed;

  @override
  State<DrugsView> createState() => _DrugsViewState();
}

class _DrugsViewState extends State<DrugsView> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

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

  void _onSearchChange() => context.read<DrugsCubit>().onSearchChanged(_searchController.text);

  /// Выйти из поиска: очистить поле без лишнего запроса (listener снят на время
  /// clear) и переключить режим — cubit сам перезагрузит список без фильтра.
  void _exitSearch() {
    _searchController.removeListener(_onSearchChange);
    _searchController.clear();
    _searchController.addListener(_onSearchChange);
    context.read<DrugsCubit>().toggleSearch();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent) {
      context.read<DrugsCubit>().loadNextPage();
    }
  }

  /// Если первая страница не заполнила экран (широкое окно), скролла нет и
  /// догрузка по концу списка не сработает — запрашиваем следующую страницу сами.
  void _loadMoreIfNotScrollable() {
    if (!mounted || !_scrollController.hasClients) return;
    if (_scrollController.position.maxScrollExtent <= 0) {
      context.read<DrugsCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BlocBuilder<DrugsCubit, DrugsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: scheme.surface,
          appBar: AppBar(
            backgroundColor: scheme.surface,
            shadowColor: Colors.transparent,
            leading: state.isSearchActive
                ? IconButton(
                    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                    onPressed: _exitSearch,
                    icon: Icon(Icons.arrow_back_ios_new, color: scheme.primary),
                  )
                : IconButton(
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    onPressed: widget.onMenuPressed,
                    icon: Icon(Icons.menu, color: scheme.primary),
                  ),
            title: _buildTitle(state),
            actions: [
              if (!state.isSearchActive)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    tooltip: MaterialLocalizations.of(context).searchFieldLabel,
                    onPressed: () => context.read<DrugsCubit>().toggleSearch(),
                    icon: Icon(Icons.search, color: scheme.primary),
                  ),
                ),
            ],
            centerTitle: true,
          ),
          body: ContentWidth(maxWidth: ContentWidth.reading, child: _buildBody(state)),
        );
      },
    );
  }

  Widget _buildTitle(DrugsState state) {
    final theme = Theme.of(context);
    if (!state.isSearchActive) {
      return Text(LocaleKeys.commonDrugs.tr(), style: TextStyle(color: theme.colorScheme.onSurface));
    }
    return SizedBox(
      height: 40.0,
      child: TextField(
        autofocus: true,
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          hintText: LocaleKeys.commonSearch.tr(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          prefixIcon: Icon(Icons.search, size: 20.0, color: theme.colorScheme.primary),
          prefixIconConstraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36.0, minHeight: 40.0),
            style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            tooltip: MaterialLocalizations.of(context).clearButtonTooltip,
            onPressed: _searchController.clear,
            icon: Icon(Icons.close, size: 18.0, color: theme.colorScheme.primary),
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 36.0, minHeight: 40.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
      ),
    );
  }

  Widget _buildBody(DrugsState state) {
    return DataStateBuilder<List<Drug>>(
      state: state.data,
      loader: (_) => const LoaderHolderWidget(),
      errorBuilder: (_, error) => ErrorHolderWidget(error: error, onPressed: () => context.read<DrugsCubit>().reload()),
      builder: (_, data) => data.isEmpty ? _buildEmptyState(state) : _buildList(state, data),
    );
  }

  Widget _buildList(DrugsState state, List<Drug> data) {
    return RefreshIndicator(
      onRefresh: () => context.read<DrugsCubit>().reload(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = AdaptiveColumns.forWidth(constraints.maxWidth);
          WidgetsBinding.instance.addPostFrameCallback((_) => _loadMoreIfNotScrollable());
          return CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
              SliverList(
                delegate: SliverChildBuilderDelegate((_, row) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    child: AdaptiveCardRow(
                      columns: columns,
                      children: [for (final drug in data.skip(row * columns).take(columns)) DrugCard(drug: drug)],
                    ),
                  );
                }, childCount: AdaptiveColumns.rowCount(data.length, columns)),
              ),
              SliverToBoxAdapter(child: _buildPageFooter(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPageFooter(DrugsState state) {
    return DataStateBuilder<int>(
      state: state.page,
      builder: (_, _) => const SizedBox(height: 16.0),
      loader: (_) => const SizedBox(height: 48.0, child: Center(child: CircularProgressIndicator())),
      errorBuilder: (_, _) => SizedBox(
        height: 64.0,
        child: Center(
          child: TextButton(
            onPressed: () => context.read<DrugsCubit>().loadNextPage(),
            child: Text(LocaleKeys.commonReloadBtn.tr()),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(DrugsState state) {
    // При активном поиске пустой список означает «ничего не найдено».
    final message = state.searchRequest.isNotEmpty ? LocaleKeys.commonNotFound.tr() : LocaleKeys.drugsEmptyState.tr();
    return RefreshIndicator(
      onRefresh: () => context.read<DrugsCubit>().reload(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
          ),
        ),
      ),
    );
  }
}

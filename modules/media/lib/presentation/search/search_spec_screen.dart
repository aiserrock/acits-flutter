import 'package:util/util.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:l10n/l10n.dart';
import 'package:animals/animals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:media/presentation/presentation.dart';

/// Экран поиска вида животного. Возвращает выбранный [AnimalSpecies] через `pop`.
class SearchScreen extends StatelessWidget {
  const SearchScreen({required this.repository, required this.shelterProvider, this.parentSearch, super.key});

  final AnimalRepository repository;
  final CurrentShelterProvider shelterProvider;
  final AnimalSpecies? parentSearch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchSpecCubit(repository, shelterProvider, parentSearch: parentSearch),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  late final NavigatorState _navigator;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChange);
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigator = Navigator.of(context);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChange);
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: CupertinoButton(
          onPressed: _navigator.pop,
          child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.primary),
        ),
        title: _buildTitle(context),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: TextField(
        autofocus: true,
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 16.0, right: 8.0),
          suffix: GestureDetector(
            onTap: _searchController.clear,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: MediaAssets.closeIconSvg(height: 16.0, width: 16.0, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SearchSpecCubit, SearchSpecState>(
      builder: (context, state) {
        return DataStateBuilder<List<AnimalSpecies>>(
          state: state.data,
          builder: (context, list) => _buildList(context, list, state),
          loader: (_) => const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, _) => ErrorStubWidget(
            image: MediaAssets.errorStubSvg(),
            onPressed: () => context.read<SearchSpecCubit>().loadData(searchRequest: _searchQuery, resetOffset: true),
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<AnimalSpecies> list, SearchSpecState state) {
    return list.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () => context.read<SearchSpecCubit>().loadData(searchRequest: _searchQuery, resetOffset: true),
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Builder(
                        builder: (context) {
                          return ListTile(
                            title: Text(list[index].name),
                            onTap: () {
                              _onItemPressed(list[index]);
                            },
                          );
                        },
                      ),
                    ),
                    childCount: list.length,
                  ),
                ),
                SliverToBoxAdapter(child: _buildPagingFooter(state)),
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 120.0, width: 120.0, child: MediaAssets.emptyStateSvg()),
                const SizedBox(height: 32.0),
                Text(LocaleKeys.commonNotFound.tr(), style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          );
  }

  Widget _buildPagingFooter(SearchSpecState state) {
    if (state.isPaging) {
      return const SizedBox(height: 64.0, child: Center(child: CircularProgressIndicator()));
    }
    if (state.pagingError != null) {
      return SizedBox(height: 64.0, child: Center(child: Text(LocaleKeys.commonError.tr())));
    }
    return const SizedBox(height: 16.0);
  }

  String? get _searchQuery => _searchController.text.isNotEmpty ? _searchController.text : null;

  void _onItemPressed(AnimalSpecies item) {
    _navigator.pop(item);
  }

  void _onSearchChange() {
    context.read<SearchSpecCubit>().onSearchChanged(_searchController.text);
  }

  void _onScroll() {
    final positions = _scrollController.position;
    if (positions.pixels >= positions.maxScrollExtent) {
      context.read<SearchSpecCubit>().loadMore(_searchController.text);
    }
  }
}

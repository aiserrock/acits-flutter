import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/search_screen/cubit/search_spec_cubit.dart';
import 'package:acits_flutter/ui/screen/search_screen/cubit/search_spec_state.dart';
import 'package:acits_flutter/ui/widget/error_stub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Экран поиска вида животного. Возвращает выбранный [Species] через `pop`.
class SearchScreen extends StatelessWidget {
  const SearchScreen({this.parentSearch, super.key});

  final Species? parentSearch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchSpecCubit(parentSearch: parentSearch),
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
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: CupertinoButton(
          onPressed: _navigator.pop,
          child: const Icon(Icons.arrow_back_ios_new, color: ColorRes.accent),
        ),
        title: _buildTitle(),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTitle() {
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
              child: Assets.icon.close.svg(height: 16.0, width: 16.0, color: ColorRes.accent),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        style: StyleRes.content.copyWith(color: ColorRes.textPrimary),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SearchSpecCubit, SearchSpecState>(
      builder: (context, state) {
        return DataStateBuilder<List<Species>>(
          state: state.data,
          builder: (context, list) => _buildList(context, list, state),
          loader: (_) => const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, _) => ErrorStubWidget(
            onPressed: () => context.read<SearchSpecCubit>().loadData(
              searchRequest: _searchQuery,
              resetOffset: true,
            ),
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<Species> list, SearchSpecState state) {
    return list.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () => context.read<SearchSpecCubit>().loadData(
              searchRequest: _searchQuery,
              resetOffset: true,
            ),
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
                            title: Text(list[index].name ?? ''),
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
                SizedBox(height: 120.0, width: 120.0, child: Assets.common.emptyState.svg()),
                const SizedBox(height: 32.0),
                Text(StringRes.current.commonNotFound, style: StyleRes.title),
              ],
            ),
          );
  }

  Widget _buildPagingFooter(SearchSpecState state) {
    if (state.isPaging) {
      return const SizedBox(height: 64.0, child: Center(child: CircularProgressIndicator()));
    }
    if (state.pagingError != null) {
      return SizedBox(height: 64.0, child: Center(child: Text(StringRes.current.commonError)));
    }
    return const SizedBox(height: 16.0);
  }

  String? get _searchQuery => _searchController.text.isNotEmpty ? _searchController.text : null;

  void _onItemPressed(Species item) {
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

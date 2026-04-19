import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/ui/screen/search_screen/search.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/error_stub.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchContent<T> extends StatefulWidget {
  const SearchContent({this.tileBuilder, super.key});

  final Widget Function(T item)? tileBuilder;

  @override
  State<SearchContent<T>> createState() => _SearchContentState<T>();
}

class _SearchContentState<T> extends State<SearchContent<T>> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChange);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChange)
      ..dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, color: ColorRes.accent),
        ),
        title: _buildTitle(),
        centerTitle: true,
      ),
      body: _buildBody(context),
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

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<SearchBloc<T>, SearchState<T>>(
      builder: (_, state) {
        return state.isInitFailure
            ? Center(
                child: ErrorStubWidget(
                  onPressed: () => context.read<SearchBloc<T>>().add(const ResetFetchSearchEvent()),
                ),
              )
            : state.isInitLoading
            ? const LoaderHolderWidget()
            : _buildList(context);
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return BlocBuilder<SearchBloc<T>, SearchState<T>>(
      builder: (context, state) {
        return state.items.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async =>
                    context.read<SearchBloc<T>>().add(const ResetFetchSearchEvent()),
                child: CustomScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: _scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((_, index) {
                        final item = state.items[index];
                        final tileBuilder = widget.tileBuilder;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: tileBuilder != null
                              ? CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => Navigator.of(context).pop(item),
                                  child: tileBuilder.call(item),
                                )
                              : ListTile(
                                  title: Text(item.toString()),
                                  onTap: () => Navigator.of(context).pop(item),
                                ),
                        );
                      }, childCount: state.items.length),
                    ),
                    SliverToBoxAdapter(child: _ListEnding<T>()),
                  ],
                ),
              )
            : const _EmptyStub();
      },
    );
  }

  void _onScroll() {
    final positions = _scrollController.position;
    if (positions.pixels >= positions.maxScrollExtent) {
      context.read<SearchBloc<T>>().add(const FetchNextSearchEvent());
    }
  }

  void _onSearchChange() {
    context.read<SearchBloc<T>>().add(ChangeSearchRequestSearchEvent(_searchController.text));
  }
}

class _EmptyStub extends StatelessWidget {
  const _EmptyStub();

  @override
  Widget build(BuildContext context) {
    return Center(
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
}

class _ListEnding<T> extends StatelessWidget {
  const _ListEnding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc<T>, SearchState<T>>(
      builder: (_, state) {
        return state.isLoading
            ? const SizedBox(height: 64.0, child: Center(child: CircularProgressIndicator()))
            : state.hasError
            ? SizedBox(height: 64.0, child: Center(child: Text(StringRes.current.commonError)))
            : const SizedBox(height: 16.0);
      },
    );
  }
}

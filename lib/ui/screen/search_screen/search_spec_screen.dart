import 'dart:async';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/widget/error_stub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _searchBouncePeriod = Duration(milliseconds: 1000);

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    this.parentSearch,
    Key? key,
  }) : super(key: key);

  final Species? parentSearch;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _service = getIt<AnimalService>();
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _bounceTimer;
  late final NavigatorState _navigator;

  int _speciesListOffset = 0;
  final _speciesState = WidgetState<List<Species>>()..loading();
  final _listPagingState = WidgetState<Object>()..content(Object());

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
    _scrollController.removeListener(_onScroll);
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
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: ColorRes.accent,
          ),
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
          contentPadding: const EdgeInsets.only(
            left: 16.0,
            right: 8.0,
          ),
          suffix: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Assets.icon.close.svg(height: 16.0, width: 16.0, color: ColorRes.accent),
            ),
            onTap: _searchController.clear,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        style: StyleRes.content.copyWith(color: ColorRes.textPrimary),
      ),
    );
  }

  Widget _buildBody() {
    return StateBuilder<List<Species>>(
      state: _speciesState,
      builder: _buildList,
      loader: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorBuilder: (_, __) => ErrorStubWidget(onPressed: () => _loadData(resetOffset: true)),
    );
  }

  Widget _buildList(context, List<Species> list) {
    return list.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () => _loadData(resetOffset: true),
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: Builder(builder: (context) {
                        return ListTile(
                          title: Text(list[index].name ?? ''),
                          onTap: () {
                            _onItemPressed(
                              context,
                              list[index],
                            );
                          },
                        );
                      }),
                    ),
                    childCount: list.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: StateBuilder(
                    state: _listPagingState,
                    builder: (_, __) => const SizedBox(height: 16.0),
                    loader: (_) => const SizedBox(
                      height: 64.0,
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
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 120.0,
                  width: 120.0,
                  child: Assets.common.emptyState.svg(),
                ),
                const SizedBox(height: 32.0),
                const Text(
                  'Ничего не нашлось :(',
                  style: StyleRes.title,
                ),
              ],
            ),
          );
  }

  void _onItemPressed(
    BuildContext context,
    Species item,
  ) {
    _navigator.pop(item);
  }

  void _onSearchChange() {
    if (_searchController.text.isEmpty) {
      _bounceTimer?.cancel();
      _loadData();
      return;
    }
    _bounceTimer?.cancel();
    _bounceTimer = Timer(
      _searchBouncePeriod,
      () => _loadData(resetOffset: true),
    );
  }

  void _onScroll() {
    final positions = _scrollController.position;
    if (positions.pixels >= positions.maxScrollExtent && !_listPagingState.isLoading) _loadData();
  }

  Future<void> _loadData({bool resetOffset = false}) async {
    if (resetOffset) {
      setState(
        () {
          _speciesListOffset = 0;
          _speciesState.loading();
        },
      );
    }
    if (!_speciesState.isLoading) {
      setState(() => _listPagingState.loading());
    }
    _service
        .getAnimalSpecies(
      level: _service.getLevel(int.tryParse(widget.parentSearch?.level.toString() ?? '0') ?? 0),
      parentId: widget.parentSearch?.id,
      offset: _speciesListOffset,
      searchRequest: _searchController.text.isNotEmpty ? _searchController.text : null,
    )
        .then(
      (value) {
        setState(
          () {
            _speciesListOffset += value.length;
            final list = (_speciesState.value ?? [])..addAll(value);
            _speciesState.content(list);
            _listPagingState.content(Object());
          },
        );
      },
    ).onError(
      (error, stackTrace) {
        if (_speciesState.isLoading) {
          setState(() => _speciesState.error = error);
        } else {
          setState(() => _listPagingState.error = error);
        }
      },
    );
  }
}

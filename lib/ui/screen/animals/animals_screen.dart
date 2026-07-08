import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/locale_keys.g.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/ui/screen/animals/cubit/animals_cubit.dart';
import 'package:acits_flutter/ui/screen/animals/cubit/animals_state.dart';
import 'package:acits_flutter/ui/screen/root_screen.dart';
import 'package:acits_flutter/ui/widget/animal_card.dart';
import 'package:acits_flutter/ui/widget/screen_loader.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:easy_localization/easy_localization.dart';

const _scrollTopPadding = 16.0;

class AnimalsScreen extends StatelessWidget {
  const AnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AnimalsCubit(), child: const _AnimalsView());
  }
}

class _AnimalsView extends StatefulWidget {
  const _AnimalsView();

  @override
  State<_AnimalsView> createState() => _AnimalsViewState();
}

class _AnimalsViewState extends State<_AnimalsView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
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
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimalsCubit, AnimalsState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: ColorRes.background,
          appBar: AppBar(
            backgroundColor: ColorRes.foreground,
            shadowColor: Colors.transparent,
            leading: GestureDetector(
              onTap: RootDrawerProvider.of(context)?.openDrawer,
              child: const Icon(Icons.menu, color: ColorRes.accent),
            ),
            title: _buildTitle(state),
            actions: _buildAppBarActions(state),
            centerTitle: true,
          ),
          floatingActionButton: _buidFab(),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buidFab() {
    return FloatingActionButton(
      heroTag: 'AnimalsFab',
      mini: _isSmallScreen,
      onPressed: () async {
        final cubit = context.read<AnimalsCubit>();
        context.push<bool>(AppRoutes.animalEdit).then((bool? isAdded) {
          if (isAdded ?? false) cubit.loadAnimalList(needResetOffset: true);
        });
      },
      backgroundColor: ColorRes.accent,
      child: const Icon(Icons.add, color: ColorRes.foreground),
    );
  }

  List<Widget> _buildAppBarActions(AnimalsState state) {
    return [
      if (!state.isSearchActive)
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: const Icon(Icons.search, color: ColorRes.accent),
            onTap: () => context.read<AnimalsCubit>().toggleSearch(),
          ),
        ),
    ];
  }

  Widget _buildBody(AnimalsState state) {
    return DataStateBuilder<List<AnimalRead>>(
      state: state.data,
      loader: (_) => ScreenLoader(
        height: 160.0,
        pullToRefresh: () => context.read<AnimalsCubit>().loadAnimalList(needResetOffset: true),
      ),
      builder: (_, data) => _buildScreenContent(state, data),
      errorBuilder: (_, _) => Column(),
    );
  }

  Widget _buildTitle(AnimalsState state) {
    return state.isSearchActive
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
                  onTap: () => context.read<AnimalsCubit>().toggleSearch(),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
              style: StyleRes.content.copyWith(color: ColorRes.textPrimary),
            ),
          )
        : Text(LocaleKeys.commonAnimals.tr(), style: const TextStyle(color: ColorRes.textPrimary));
  }

  Widget _buildScreenContent(AnimalsState state, List<AnimalRead> data) {
    return data.isEmpty ? _buildEmptyState() : _buildList(state, data);
  }

  Widget _buildList(AnimalsState state, List<AnimalRead> data) {
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
                final isDeleted = animal.deletedAt != null;
                return isDeleted
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                        child: AnimalCardWidget(animal, onDelete: () => _onDelete(context, animal)),
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
      loader: (_) =>
          const SizedBox(height: 48.0, child: Center(child: CircularProgressIndicator())),
      errorBuilder: (_, _) =>
          SizedBox(height: 64.0, child: Center(child: Text(LocaleKeys.commonError.tr()))),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () => context.read<AnimalsCubit>().loadAnimalList(needResetOffset: true),
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
                LocaleKeys.mainEmptyState.tr(),
                style: const TextStyle(fontSize: 16.0, color: ColorRes.textSecondary),
              ),
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

  Future<void> _onDelete(BuildContext context, AnimalRead? item) async {
    if (item == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<AnimalsCubit>().deleteAnimal(item);
    if (!success) {
      messenger.showSnackBar(SnackBar(content: Text(LocaleKeys.errorDefaultMsg.tr())));
    }
  }
}

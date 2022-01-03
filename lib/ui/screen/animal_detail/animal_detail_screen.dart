import 'dart:math';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'animal_card_header.dart';

class AnimalDetailScreen extends StatefulWidget {
  const AnimalDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  final int id;

  @override
  _AnimalDetailScreenState createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  late bool _isSmallScreen;
  int _currentTab = 0;

  WidgetState<Animal> _state = WidgetState()..loading();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isSmallScreen = MediaQuery.of(context).size.width <= 340.0;
    _scrollController.addListener(_onScroll);
  }

  @override
  void initState() {
    super.initState();
    _loadAnimal();
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
      body: _buildBody(),
    );
  }

  Widget _buildDrawer() => const Drawer();

  Widget _buildBody() {
    return SafeArea(
      child: StateBuilder<Animal>(
        state: _state,
        builder: _buildContent,
        errorBuilder: (_, __) => Container(
          child: Text('error'),
        ),
        loader: (_) => Container(
          child: Text('loader'),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Animal animal) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _AnimalCardHeaderDelegate(
            animal,
            tabBar: _buildTabBar(),
          ),
        ),
        _buildPage((_currentTab + 1) * 5),
      ],
    );
  }

  SliverList _buildPage(int count) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.filled(
          count,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 64.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorRes.textSecondary,
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<int>(
          children: <int, Widget>{
            0: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.animalFace.svg(
                color: _currentTab == 0 ? ColorRes.accent : Colors.white,
              ),
            ),
            1: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.prescription.svg(
                color: _currentTab == 1 ? ColorRes.accent : Colors.white,
              ),
            ),
            2: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.curator.svg(
                color: _currentTab == 2 ? ColorRes.accent : Colors.white,
              ),
            ),
            3: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.applicant.svg(
                color: _currentTab == 3 ? ColorRes.accent : Colors.white,
              ),
            ),
            4: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.comment.svg(
                color: _currentTab == 4 ? ColorRes.accent : Colors.white,
              ),
            ),
          },
          groupValue: _currentTab,
          backgroundColor: ColorRes.indicatorActive,
          onValueChanged: (int? index) => setState(() {
            if (index != null) _currentTab = index;
          }),
        ),
      ),
    );
  }

  void _onScroll() {}

  Future<void> _loadAnimal() async {
    setState(() => _state = WidgetState()..loading());
    await getIt<AnimalService>()
        .fetchAnimalDetail(id: widget.id)
        .then((value) => setState(() => _state = WidgetState()..content(value)))
        .catchError((e) => setState(() => _state = WidgetState()..error = e));
  }
}

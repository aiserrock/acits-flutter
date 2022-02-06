import 'dart:async';
import 'dart:math';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/ui/screen/animal_detail/animal_content_card.dart';
import 'package:acits_flutter/ui/widget/animal_prescription_card.dart';
import 'package:acits_flutter/ui/widget/error_stub.dart';
import 'package:acits_flutter/ui/widget/skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'animal_card_header.dart';
part 'animal_common_info.dart';
part 'animal_prescriptions.dart';
part 'animal_curator.dart';
part 'animal_applicant.dart';
part 'animal_detail_stub.dart';

final _dateFormatter = DateFormat('dd.MM.yyyy');

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

  WidgetState<AnimalRead> _state = WidgetState()..loading();
  WidgetState<List<AnimalPrescription?>?> _statePrescriptions = WidgetState()..loading();

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
    _loadPrescriptions();
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
      floatingActionButton: _buildFab(),
    );
  }

  FloatingActionButton? _buildFab() {
    return (_currentTab == 1 || _currentTab == 4)
        ? FloatingActionButton(
            mini: _isSmallScreen,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            foregroundColor: ColorRes.accent,
            onPressed: () {},
          )
        : null;
  }

  Widget _buildDrawer() => const Drawer();

  Widget _buildBody() {
    return SafeArea(
      child: StateBuilder<AnimalRead>(
        state: _state,
        builder: _buildContent,
        errorBuilder: (_, error) => _AnimalDetailStub(
          error: error,
          onRefresh: _loadAnimal,
        ),
        loader: (_) => _AnimalDetailStub(
          onRefresh: _loadAnimal,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AnimalRead animal) {
    return RefreshIndicator(
      onRefresh: _loadAnimal,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _AnimalCardHeaderDelegate(
              animal,
              tabBar: _buildTabBar(),
            ),
          ),
          _buildPage((_currentTab + 1) * 5, animal),
        ],
      ),
    );
  }

  SliverList _buildPage(int count, AnimalRead animal) {
    switch (_currentTab) {
      case 0:
        return _buildCommonInfoPage(animal);
      case 1:
        return _buildPrescriptionsPage(_statePrescriptions);
      case 2:
        return _buildCuratorPage(animal);
      case 3:
        return _buildApplicantPage(animal);
      default:
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
                      color: ColorRes.textSecondary, borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
          ),
        );
    }
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
                height: 28.0,
                width: 28.0,
                color: _currentTab == 0 ? ColorRes.accent : Colors.white,
              ),
            ),
            1: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.prescription.svg(
                height: 28.0,
                width: 28.0,
                color: _currentTab == 1 ? ColorRes.accent : Colors.white,
              ),
            ),
            2: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.curator.svg(
                height: 28.0,
                width: 28.0,
                color: _currentTab == 2 ? ColorRes.accent : Colors.white,
              ),
            ),
            3: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.applicant.svg(
                height: 28.0,
                width: 28.0,
                color: _currentTab == 3 ? ColorRes.accent : Colors.white,
              ),
            ),
            4: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.comment.svg(
                height: 28.0,
                width: 28.0,
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

  Future<void> _loadPrescriptions() async {
    setState(() => _statePrescriptions = WidgetState()..loading());
    await getIt<PrescriptionService>()
        .fetchPrescriptionListByAnimal(
          widget.id,
          isOld: true,
        )
        .then(
            (value) => setState(() => _statePrescriptions = WidgetState()..content(value?.results)))
        .catchError((e) => setState(() => _state = WidgetState()..error = e));
  }
}

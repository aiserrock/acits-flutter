import 'dart:math';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_add_info_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_applicant_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_common_info_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_curator_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_status_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Экран создания или редактирования существующих животных
class AnimalEditScreen extends StatefulWidget {
  const AnimalEditScreen({
    this.id,
    Key? key,
  }) : super(key: key);

  final int? id;

  @override
  _AnimalEditScreenState createState() => _AnimalEditScreenState();
}

class _AnimalEditScreenState extends State<AnimalEditScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKeys = List<GlobalKey<FormState>>.generate(5, (_) => GlobalKey<FormState>());

  late final bool _isEdit;

  WidgetState<Animal> _editState = WidgetState<Animal>()..loading();
  final _pageController = PageController();

  Animal editAnimal = Animal();

  @override
  void initState() {
    super.initState();
    _isEdit = widget.id != null;
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(),
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorRes.accent,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.id == null ? StringRes.current.animalAdd : StringRes.current.animalEdit,
          style: const TextStyle(color: ColorRes.textPrimary),
        ),
        actions: [
          CupertinoButton(
            onPressed: () {},
            child: const Icon(
              Icons.done_sharp,
              color: ColorRes.accent,
            ),
          ),
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
        onPressed: _onFabPressed,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: _isEdit
            ? StateBuilder<Animal>(
                state: _editState,
                loader: (_) => Container(),
                errorBuilder: (_, __) => Container(),
                builder: (context, snapshot) {
                  return RefreshIndicator(
                    child: _buildContent(),
                    onRefresh: _init,
                  );
                })
            : _buildContent(),
      ),
    );
  }

  Widget _buildIndicator() {
    return SmoothPageIndicator(
      count: 5,
      controller: _pageController,
      onDotClicked: _scrollTo,
      effect: const ExpandingDotsEffect(
        activeDotColor: ColorRes.indicatorActive,
        dotColor: ColorRes.indicatorInactive,
        dotHeight: 8.0,
        dotWidth: 8.0,
        strokeWidth: 16.0,
      ),
    );
  }

  void _scrollTo(int index) {}

  Widget _buildContent() {
    final pages = <AnimalEditPage>[
      AnimalEditCommonInfoPage(
        animal: editAnimal,
        isEdit: _isEdit,
        validate: (_) {},
        formKey: formKeys[0],
      ),
      AnimalEditStatusPage(
        animal: editAnimal,
        isEdit: _isEdit,
        validate: (_) {},
      ),
      AnimalEditAddInfoPage(
        animal: editAnimal,
        isEdit: _isEdit,
        validate: (_) {},
      ),
      AnimalEditCuratorPage(
        animal: editAnimal,
        isEdit: _isEdit,
        validate: (_) {},
      ),
      AnimalEditApplicantPage(
        animal: editAnimal,
        isEdit: _isEdit,
        validate: (_) {},
      ),
    ];
    return Column(
      children: [
        const SizedBox(height: 24.0),
        _buildIndicator(),
        Expanded(
          child: PageView(
            physics: const ClampingScrollPhysics(),
            onPageChanged: _onPageChanged,
            controller: _pageController,
            children: pages,
          ),
        ),
      ],
    );
  }

  void _onFabPressed() {
    if (!_pageController.hasClients) return;
    final page = _pageController.page!.round();
    final isValid = formKeys[page].currentState?.validate() ?? true;
    if (isValid) {
      _pageController.nextPage(
        duration: kTabScrollDuration,
        curve: Curves.linear,
      );
    }
  }

  void _onPageChanged(int index) {
    final isValid = formKeys[max(0, index - 1)].currentState?.validate() ?? true;
    if (!isValid) {
      _pageController.previousPage(
        duration: kTabScrollDuration,
        curve: Curves.linear,
      );
    }
  }

  Future<void> _init() async {
    if (widget.id == null) return;
    setState(() => _editState = WidgetState<Animal>()..loading());
    await getIt<AnimalService>()
        .fetchAnimalDetail(id: widget.id!)
        .then(
          (value) => setState(
            () {
              _editState = WidgetState()..content(value);
              editAnimal = value;
            },
          ),
        )
        .catchError((e) => setState(() => _editState = WidgetState()..error = e));
  }
}

import 'dart:math';

import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:acits_flutter/ui/widget/success_holder.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_pager_holder.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_add_info_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_applicant_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_common_info_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_curator_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_status_page.dart';
import 'package:acits_flutter/export.dart';

const _onPageChangedBackDuration = Duration(milliseconds: 500);

/// Экран создания или редактирования существующих животных
class AnimalEditScreen extends StatefulWidget {
  const AnimalEditScreen({this.id, super.key});

  final int? id;

  @override
  State<AnimalEditScreen> createState() => _AnimalEditScreenState();
}

class _AnimalEditScreenState extends State<AnimalEditScreen> {
  late final AnimalService _animalService;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKeys = List<GlobalKey<FormState>>.generate(5, (_) => GlobalKey<FormState>());

  late final bool _isEdit;
  late final NavigatorState _navigator;

  ScreenDataState<_AnimalEditScreenMode> _editState = ScreenDataState<_AnimalEditScreenMode>(
    _AnimalEditScreenMode.form,
  );
  final _pageController = PageController();

  bool _isLastPage = false;

  bool _isUploadProgress = false;

  @override
  void initState() {
    super.initState();
    _animalService = getIt<AnimalService>();
    _isEdit = widget.id != null;
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigator = Navigator.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnimalEditPagerHolder>(
      create: (_) => AnimalEditPagerHolder(),
      builder: (context, snapshot) {
        return ChangeNotifierProvider<AnimalEditHolder>(
          create: (_) => AnimalEditHolder(),
          builder: (_, _) {
            return Scaffold(
              key: scaffoldKey,
              drawer: const Drawer(),
              backgroundColor: ColorRes.background,
              appBar: AppBar(
                backgroundColor: ColorRes.foreground,
                shadowColor: Colors.transparent,
                leading: GestureDetector(
                  child: const Icon(Icons.arrow_back_ios, color: ColorRes.accent),
                  onTap: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  widget.id == null ? StringRes.current.animalAdd : StringRes.current.animalEdit,
                  style: const TextStyle(color: ColorRes.textPrimary),
                ),
                centerTitle: true,
              ),
              floatingActionButton:
                  (_editState.value != _AnimalEditScreenMode.success && !_editState.hasError)
                  ? FloatingActionButton(
                      onPressed: _onFabPressed,
                      backgroundColor: ColorRes.accent,
                      child: Icon(
                        _isLastPage ? Icons.done_all : Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    )
                  : null,
              body: _buildBody(),
            );
          },
        );
      },
    );
  }

  Widget _buildBody() {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: StateBuilder<_AnimalEditScreenMode>(
          state: _editState,
          loader: (_) => const LoaderHolderWidget(),
          errorBuilder: (_, e) => ErrorHolderWidget(
            error: e,
            button: 'Вернуться'.toUpperCase(),
            onPressed: () => setState(() {
              _editState = ScreenDataState<_AnimalEditScreenMode>(_AnimalEditScreenMode.form);
            }),
          ),
          builder: (context, mode) {
            return mode == _AnimalEditScreenMode.form
                ? _isEdit
                      ? RefreshIndicator(onRefresh: _init, child: _buildContent(context))
                      : _buildContent(context)
                : SuccessHolderWidget(
                    onPressed: () => _navigator.pop(true),
                    title: 'Готово!',
                    message: 'Изменения сохранены.',
                    button: 'Закрыть'.toUpperCase(),
                  );
          },
        ),
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

  Widget _buildContent(BuildContext context) {
    final pages = <Widget>[
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditCommonInfoPage(animal: holder.state, isEdit: _isEdit, formKey: formKeys[0]),
      ),
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditStatusPage(animal: holder.state, isEdit: _isEdit, formKey: formKeys[1]),
      ),
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditAddInfoPage(animal: holder.state, isEdit: _isEdit, formKey: formKeys[2]),
      ),
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditCuratorPage(animal: holder.state, isEdit: _isEdit),
      ),
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditApplicantPage(animal: holder.state, isEdit: _isEdit, formKey: formKeys[4]),
      ),
    ];
    return Column(
      children: [
        if (_isUploadProgress)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(height: 48.0, child: Center(child: CircularProgressIndicator())),
          ),
        const SizedBox(height: 16.0),
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
      _getProvider<AnimalEditPagerHolder>()?.set(max(0, page));
      _pageController.nextPage(duration: kTabScrollDuration, curve: Curves.linear);
      if (_isLastPage && !_isUploadProgress && _editState.value != _AnimalEditScreenMode.success) {
        _onSubmit();
      }
    }
  }

  void _onPageChanged(int index) {
    setState(() => _isLastPage = index == 4);
    final isValid = formKeys[max(0, index - 1)].currentState?.validate() ?? true;
    if (!isValid) {
      Future.delayed(
        _onPageChangedBackDuration,
        () => _pageController.previousPage(duration: kTabScrollDuration, curve: Curves.linear),
      );
    } else {
      _getProvider<AnimalEditPagerHolder>()?.set(max(0, index - 1));
    }
  }

  Future<void> _init() async {
    if (!_isEdit) return;
    setState(() => _editState = ScreenDataState<_AnimalEditScreenMode>()..loading());
    await _animalService
        .fetchAnimalDetail(id: widget.id!)
        .then((value) {
          _getProvider<AnimalEditHolder>()?.init(value);
          setState(() {
            _editState = ScreenDataState()..content(_AnimalEditScreenMode.form);
          });
        })
        .catchError((e) {
          setState(() => _editState = ScreenDataState()..error = e);
        });
  }

  Future<void> _onSubmit() async {
    setState(() => _isUploadProgress = true);
    final editedAnimal = _getProvider<AnimalEditHolder>()?.state;
    if (editedAnimal != null) {
      AnimalRead? result;
      final isEdit = _isEdit && editedAnimal.id != null;
      if (isEdit) {
        result = await _animalService
            .updateAnimal(editedAnimal.id!, editedAnimal.write)
            .catchError((_) => null);
      } else {
        result = await _animalService.createAnimal(editedAnimal.write).catchError((e) {
          setState(() {
            _editState = ScreenDataState()..error = e;
          });
          return null;
        });
      }
      if (result != null) {
        setState(() => _editState = ScreenDataState()..content(_AnimalEditScreenMode.success));
      }
    }
    setState(() => _isUploadProgress = false);
  }

  T? _getProvider<T extends ChangeNotifier>() {
    final scaffoldState = scaffoldKey.currentState;
    if (scaffoldState != null) {
      return Provider.of<T>(scaffoldState.context, listen: false);
    }
    return null;
  }
}

enum _AnimalEditScreenMode { form, success }

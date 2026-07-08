import 'dart:math';

import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:acits_flutter/ui/widget/success_holder.dart';
import 'package:acits_flutter/ui/screen/animal_edit/cubit/animal_edit_cubit.dart';
import 'package:acits_flutter/ui/screen/animal_edit/cubit/animal_edit_state.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_pager_holder.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_add_info_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_applicant_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_common_info_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_curator_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_status_page.dart';
import 'package:acits_flutter/export.dart';

const _onPageChangedBackDuration = Duration(milliseconds: 500);

/// Экран создания или редактирования существующих животных.
///
/// Данными загрузки/ошибки/успеха владеет [AnimalEditCubit]; форма страниц
/// живёт в [AnimalEditHolder]/[AnimalEditPagerHolder] (ChangeNotifier),
/// UI-контроллеры — во [State] вью.
class AnimalEditScreen extends StatelessWidget {
  const AnimalEditScreen({this.id, super.key});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnimalEditPagerHolder>(
      create: (_) => AnimalEditPagerHolder(),
      child: ChangeNotifierProvider<AnimalEditHolder>(
        create: (_) => AnimalEditHolder(),
        child: BlocProvider<AnimalEditCubit>(
          create: (_) => AnimalEditCubit(id: id),
          child: const _AnimalEditView(),
        ),
      ),
    );
  }
}

class _AnimalEditView extends StatefulWidget {
  const _AnimalEditView();

  @override
  State<_AnimalEditView> createState() => _AnimalEditViewState();
}

class _AnimalEditViewState extends State<_AnimalEditView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKeys = List<GlobalKey<FormState>>.generate(5, (_) => GlobalKey<FormState>());

  late final NavigatorState _navigator;
  final _pageController = PageController();

  bool _isLastPage = false;
  bool _isUploadProgress = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigator = Navigator.of(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnimalEditCubit>();
    return BlocConsumer<AnimalEditCubit, DataState<AnimalEditContent>>(
      listenWhen: (prev, next) => next.valueOrNull?.animal != null,
      listener: (_, state) {
        final animal = state.valueOrNull?.animal;
        if (animal != null) context.read<AnimalEditHolder>().init(animal);
      },
      builder: (context, state) {
        final mode = state.valueOrNull?.mode ?? AnimalEditScreenMode.form;
        final showFab = mode != AnimalEditScreenMode.success && !state.hasError;
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
              cubit.isEdit ? LocaleKeys.animalEdit.tr() : LocaleKeys.animalAdd.tr(),
              style: const TextStyle(color: ColorRes.textPrimary),
            ),
            centerTitle: true,
          ),
          floatingActionButton: showFab
              ? FloatingActionButton(
                  onPressed: _onFabPressed,
                  backgroundColor: ColorRes.accent,
                  child: Icon(
                    _isLastPage ? Icons.done_all : Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                )
              : null,
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(DataState<AnimalEditContent> state) {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: DataStateBuilder<AnimalEditContent>(
          state: state,
          loader: (_) => const LoaderHolderWidget(),
          errorBuilder: (_, e) => ErrorHolderWidget(
            error: e,
            button: LocaleKeys.commonBack.tr().toUpperCase(),
            onPressed: () => context.read<AnimalEditCubit>().resetToForm(),
          ),
          builder: (context, content) {
            final isEdit = context.read<AnimalEditCubit>().isEdit;
            return content.mode == AnimalEditScreenMode.form
                ? isEdit
                      ? RefreshIndicator(
                          onRefresh: () => context.read<AnimalEditCubit>().reload(),
                          child: _buildContent(context, isEdit),
                        )
                      : _buildContent(context, isEdit)
                : SuccessHolderWidget(
                    onPressed: () => _navigator.pop(true),
                    title: LocaleKeys.animalEditSuccessTitle.tr(),
                    message: LocaleKeys.animalEditSuccessMessage.tr(),
                    button: LocaleKeys.commonClose.tr().toUpperCase(),
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

  Widget _buildContent(BuildContext context, bool isEdit) {
    final pages = <Widget>[
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditCommonInfoPage(animal: holder.state, isEdit: isEdit, formKey: formKeys[0]),
      ),
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditStatusPage(animal: holder.state, isEdit: isEdit, formKey: formKeys[1]),
      ),
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditAddInfoPage(animal: holder.state, isEdit: isEdit, formKey: formKeys[2]),
      ),
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditCuratorPage(animal: holder.state, isEdit: isEdit),
      ),
      Consumer<AnimalEditHolder>(
        builder: (context, holder, _) =>
            AnimalEditApplicantPage(animal: holder.state, isEdit: isEdit, formKey: formKeys[4]),
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
      context.read<AnimalEditPagerHolder>().set(max(0, page));
      _pageController.nextPage(duration: kTabScrollDuration, curve: Curves.linear);
      final mode = context.read<AnimalEditCubit>().state.valueOrNull?.mode;
      if (_isLastPage && !_isUploadProgress && mode != AnimalEditScreenMode.success) {
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
      context.read<AnimalEditPagerHolder>().set(max(0, index - 1));
    }
  }

  Future<void> _onSubmit() async {
    setState(() => _isUploadProgress = true);
    final editedAnimal = context.read<AnimalEditHolder>().state;
    await context.read<AnimalEditCubit>().submit(editedAnimal);
    if (mounted) setState(() => _isUploadProgress = false);
  }
}

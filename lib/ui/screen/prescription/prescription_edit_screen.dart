import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

import 'package:acits_flutter/ui/screen/prescription/prescription_form.dart';
import 'package:acits_flutter/ui/screen/prescription/cubit/prescription_edit_cubit.dart';
import 'package:acits_flutter/ui/screen/prescription/cubit/prescription_edit_state.dart';
import 'package:acits_flutter/ui/widget/visible_item.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/prescription_model.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/widget/loader.dart';

/// Экран создания и редактирования назначений
class PrescriptionEditScreen extends StatelessWidget {
  const PrescriptionEditScreen({
    this.editPrescription,
    this.editPrescriptionId,
    this.animal,
    super.key,
  });

  final int? editPrescriptionId;
  final PrescriptionModel? editPrescription;
  final AnimalRead? animal;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrescriptionEditCubit(
        editPrescriptionId: editPrescriptionId,
        editPrescription: editPrescription,
        initAnimal: animal,
      ),
      child: _PrescriptionEditView(editPrescription: editPrescription),
    );
  }
}

class _PrescriptionEditView extends StatefulWidget {
  const _PrescriptionEditView({this.editPrescription});

  final PrescriptionModel? editPrescription;

  @override
  State<_PrescriptionEditView> createState() => _PrescriptionEditViewState();
}

class _PrescriptionEditViewState extends State<_PrescriptionEditView>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final NavigatorState _navigator;

  /// Контроллер вкладок типов назначения. Владеет и утилизирует его сам State.
  late final TabController tabController;

  /// Один переиспользуемый контроллер докрутки вкладки после свайпа. Раньше
  /// создавался заново в каждом onHorizontalDragEnd и никогда не dispose() —
  /// утечка Ticker на каждый свайп. Теперь живёт как поле, утилизируется в
  /// dispose().
  late final AnimationController _swipeSettleController;

  /// Контроллер поля комментария. Владеет и утилизирует его сам State
  /// (устранена утечка старого `commentContoroller`, который никогда не
  /// закрывался).
  final commentContoroller = TextEditingController();

  PrescriptionEditCubit get _cubit => context.read<PrescriptionEditCubit>();

  @override
  void initState() {
    super.initState();
    final editPrescription = widget.editPrescription;
    tabController = TabController(
      initialIndex: editPrescription != null
          ? max(PrescriptionShortMyTypeEnum.values.indexOf(editPrescription.myType), 0)
          : 0,
      length: PrescriptionShortMyTypeEnum.values.length - 1,
      vsync: this,
    );
    tabController.addListener(_onTabChanged);

    _swipeSettleController = AnimationController(vsync: this, lowerBound: -1.0, upperBound: 1.0)
      ..addListener(() => tabController.offset = _swipeSettleController.value);

    // Синхронизируем комментарий с загруженным назначением (режим правки).
    if (_cubit.isEdit) {
      _cubit.setEditedState(onComment: (comment) => commentContoroller.text = comment).then((
        tabIndex,
      ) {
        if (tabIndex != null && mounted) tabController.animateTo(tabIndex);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigator = Navigator.of(context);
  }

  @override
  void dispose() {
    _swipeSettleController.dispose();
    tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    commentContoroller.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    _cubit.onTabChanged(tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrescriptionEditCubit, PrescriptionEditState>(
      buildWhen: (prev, next) => prev.screen != next.screen,
      builder: (context, state) {
        final isLoading = state.screen.isLoading;
        final hasError = state.screen.hasError;
        return _cubit.isEdit
            ? isLoading
                  ? const Scaffold(body: LoaderHolderWidget())
                  : hasError
                  ? Scaffold(body: ErrorHolderWidget(onPressed: () => _cubit.setEditedState()))
                  : _buildForm(context)
            : _buildForm(context);
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: _buildTitle(context),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Theme.of(context).colorScheme.primary,
          indicatorWeight: 4.0,
          tabs: _cubit
              .getTabs()
              .map<Widget>(
                (tab) => SizedBox(
                  height: kTextTabBarHeight,
                  child: Center(
                    child: Text(tab, style: Theme.of(context).textTheme.titleMedium, maxLines: 2),
                  ),
                ),
              )
              .toList(),
          controller: tabController,
          isScrollable: true,
        ),
      ),
      floatingActionButton: _buildFab(context),
      body: KeyboardDismissOnTap(child: _buildBody()),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onFabPressed,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.done_all, color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  Future<void> _onFabPressed() async {
    final result = await _cubit.submit(description: commentContoroller.text, context: context);
    if (result != null) _navigator.pop(result);
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      _cubit.isEdit ? LocaleKeys.prescriptionTitleEdit.tr() : LocaleKeys.prescriptionTitleAdd.tr(),
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    );
  }

  Widget _buildBody() {
    return Builder(
      builder: (context) {
        // sizeOf вместо of(context).size — подписка только на изменение
        // размера, а не на весь MediaQuery (клавиатура/insets не триггерят
        // лишний ребилд этого поддерева).
        final sw = MediaQuery.sizeOf(context).width;
        return Column(
          children: [
            BlocSelector<PrescriptionEditCubit, PrescriptionEditState, bool>(
              selector: (state) => state.loading,
              builder: (_, loading) {
                return VisibleItem(
                  isVisible: loading,
                  child: SizedBox(
                    height: 64.0,
                    child: Center(child: LottieBuilder.asset(LottieRes.dogLoading)),
                  ),
                );
              },
            ),
            _buildAnimalField(),
            Expanded(
              child: Stack(
                children: [
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      final dx = -1 * (details.delta.dx / sw);
                      final offset = tabController.offset;
                      final dBound = dx + tabController.index;
                      if (dBound < .0 || dBound > tabController.length - 1) return;
                      tabController.offset = offset + dx;
                    },
                    onHorizontalDragEnd: (details) {
                      final indexOffset = tabController.offset.round();

                      if (indexOffset != 0) {
                        tabController.animateTo(tabController.index + indexOffset);
                      } else {
                        // Докрутить недотянутый свайп обратно к 0 через один
                        // переиспользуемый контроллер (без создания нового
                        // Ticker на каждый жест).
                        final offset = tabController.offset;
                        _swipeSettleController
                          ..stop()
                          ..value = offset;
                        _swipeSettleController.animateTo(
                          .0,
                          duration: kTabScrollDuration * offset.abs(),
                        );
                      }
                    },
                    child: PrescriptionForm(commentContoroller: commentContoroller),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimalField() {
    return BlocSelector<PrescriptionEditCubit, PrescriptionEditState, AnimalRead?>(
      selector: (state) => state.animal,
      builder: (context, animal) {
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _cubit.onAnimalPressed(context),
          child: FormEditCard([
            EditCardData(
              label: LocaleKeys.prescriptionAnimal.tr(),
              enabled: false,
              content: animal != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [Expanded(child: _buildAnimalTitle(context, animal))],
                          ),
                        ),
                        const Divider(height: 8.0, thickness: 1.0),
                      ],
                    )
                  : null,
            ),
          ]),
        );
      },
    );
  }

  Widget _buildAnimalTitle(BuildContext context, AnimalRead animal) {
    final avatarUrl = UrlCorsProxy.add(animal.avatar?.image.small);
    return Row(
      children: [
        if (avatarUrl != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(backgroundImage: NetworkImage(avatarUrl), radius: 20.0),
          ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: animal.name, style: Theme.of(context).textTheme.titleMedium),
                TextSpan(text: ', ', style: Theme.of(context).textTheme.titleMedium),
                TextSpan(
                  text: animal.id.toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: context.appColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

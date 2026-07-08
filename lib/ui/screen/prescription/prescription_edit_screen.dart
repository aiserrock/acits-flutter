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
  final Prescription? editPrescription;
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

  final Prescription? editPrescription;

  @override
  State<_PrescriptionEditView> createState() => _PrescriptionEditViewState();
}

class _PrescriptionEditViewState extends State<_PrescriptionEditView>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final NavigatorState _navigator;

  /// Контроллер вкладок типов назначения. Владеет и утилизирует его сам State.
  late final TabController tabController;

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
      initialIndex: editPrescription?.myType is MyTypeEnum
          ? max(MyTypeEnum.values.indexOf(editPrescription!.myType!), 0)
          : 0,
      length: MyTypeEnum.values.length - 1,
      vsync: this,
    );
    tabController.addListener(_onTabChanged);
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
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: ColorRes.accent),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: _buildTitle(),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: ColorRes.accent,
          indicatorWeight: 4.0,
          tabs: _cubit
              .getTabs()
              .map<Widget>(
                (tab) => SizedBox(
                  height: kTextTabBarHeight,
                  child: Center(child: Text(tab, style: StyleRes.subTitle, maxLines: 2)),
                ),
              )
              .toList(),
          controller: tabController,
          isScrollable: true,
        ),
      ),
      floatingActionButton: _buildFab(),
      body: KeyboardDismissOnTap(child: _buildBody()),
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: _onFabPressed,
      backgroundColor: ColorRes.accent,
      child: const Icon(Icons.done_all, color: Colors.white),
    );
  }

  Future<void> _onFabPressed() async {
    final result = await _cubit.submit(description: commentContoroller.text, context: context);
    if (result != null) _navigator.pop(result);
  }

  Widget _buildTitle() {
    return Text(
      _cubit.isEdit
          ? StringRes.current.prescriptionTitleEdit
          : StringRes.current.prescriptionTitleAdd,
      style: const TextStyle(color: ColorRes.textPrimary),
    );
  }

  Widget _buildBody() {
    return Builder(
      builder: (context) {
        final sw = MediaQuery.of(context).size.width;
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
                        final offset = tabController.offset;
                        final animation = AnimationController(
                          vsync: this,
                          value: offset,
                          lowerBound: -1.0,
                          duration: kTabScrollDuration * offset.abs(),
                          reverseDuration: kTabScrollDuration * offset.abs(),
                        );

                        void onAnimation() {
                          tabController.offset = animation.value;
                        }

                        animation.addListener(onAnimation);
                        animation.addStatusListener((status) {
                          if (status == AnimationStatus.completed) {
                            animation.removeListener(onAnimation);
                          }
                        });
                        animation.animateTo(.0, duration: kTabScrollDuration);
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
      builder: (_, animal) {
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _cubit.onAnimalPressed(context),
          child: FormEditCard([
            EditCardData(
              label: StringRes.current.prescriptionAnimal,
              enabled: false,
              content: animal != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [Expanded(child: _buildAnimalTitle(animal))]),
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

  Widget _buildAnimalTitle(AnimalRead animal) {
    final avatarUrl = UrlCorsProxy.add(animal.avatar?.image?.small);
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
                TextSpan(text: animal.name, style: StyleRes.subTitle),
                const TextSpan(text: ', ', style: StyleRes.subTitle),
                TextSpan(
                  text: animal.id.toString(),
                  style: StyleRes.content.copyWith(color: ColorRes.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

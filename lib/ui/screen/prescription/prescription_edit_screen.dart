import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

import 'package:acits_flutter/ui/screen/prescription/prescription_form.dart';
import 'package:acits_flutter/ui/widget/visible_item.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/ui/screen/prescription/prescription_edit_screen_controller.dart';

/// Экран создания и редактирования назначений
class PrescriptionEditScreen extends StatefulWidget {
  const PrescriptionEditScreen({
    this.editPrescription,
    this.editPrescriptionId,
    this.animal,
    Key? key,
  }) : super(key: key);

  final int? editPrescriptionId;
  final Prescription? editPrescription;
  final AnimalRead? animal;

  @override
  State<PrescriptionEditScreen> createState() => _PrescriptionEditScreenState();
}

class _PrescriptionEditScreenState extends State<PrescriptionEditScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  PrescriptionEditScreenController get controller => PrescriptionEditScreenController.controller;

  @override
  void initState() {
    getIt.pushNewScope(
      scopeName: 'PrescriptionEdit',
      init: (getIt) {
        getIt.registerSingleton<PrescriptionEditScreenController>(
          PrescriptionEditScreenController(
            scaffoldKey: scaffoldKey,
            tickerProvider: this,
            editPrescriptionId: widget.editPrescriptionId,
            editPrescription: widget.editPrescription,
            initAnimal: widget.animal,
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    getIt.popScope();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WidgetState<Prescription>?>(
        stream: controller.screenState,
        builder: (context, state) {
          final isLoading = state.data?.isLoading ?? false;
          final hasError = state.data?.hasError ?? false;
          return controller.isEdit
              ? isLoading
                  ? const Scaffold(body: LoaderHolderWidget())
                  : hasError
                      ? Scaffold(body: ErrorHolderWidget(onPressed: controller.setEditedState))
                      : _buildForm(context, controller)
              : _buildForm(context, controller);
        });
  }

  Widget _buildForm(
    BuildContext context,
    PrescriptionEditScreenController? controller,
  ) {
    return Scaffold(
      key: scaffoldKey,
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
        title: _buildTitle(),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: ColorRes.accent,
          indicatorWeight: 4.0,
          tabs: (controller?.getTabs() ?? [])
              .map<Widget>(
                (tab) => SizedBox(
                  height: kTextTabBarHeight,
                  child: Center(
                    child: Text(
                      tab,
                      style: StyleRes.subTitle,
                      maxLines: 2,
                    ),
                  ),
                ),
              )
              .toList(),
          controller: controller?.tabController,
          isScrollable: true,
        ),
      ),
      floatingActionButton: _buildFab(),
      body: KeyboardDismissOnTap(child: _buildBody()),
    );
  }

  Widget _buildFab() {
    return Builder(builder: (context) {
      return FloatingActionButton(
        child: const Icon(
          Icons.done_all,
          color: Colors.white,
        ),
        onPressed: controller.onFabPressed,
        backgroundColor: ColorRes.accent,
      );
    });
  }

  Widget _buildTitle() {
    return Builder(builder: (context) {
      final controller = PrescriptionEditScreenController.controller;
      return Text(
        controller.isEdit
            ? StringRes.current.prescriptionTitleEdit
            : StringRes.current.prescriptionTitleAdd,
        style: const TextStyle(color: ColorRes.textPrimary),
      );
    });
  }

  Widget _buildBody() {
    return Builder(builder: (context) {
      final sw = MediaQuery.of(context).size.width;
      return Column(
        children: [
          StreamBuilder<bool>(
            stream: controller.loadingState,
            builder: (_, state) {
              return VisibleItem(
                isVisible: state.data ?? false,
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
                    final offset = controller.tabController.offset;
                    final dBound = dx + controller.tabController.index;
                    if (dBound < .0 || dBound > controller.tabController.length - 1) return;
                    controller.tabController.offset = offset + dx;
                  },
                  onHorizontalDragEnd: (details) {
                    final indexOffset = controller.tabController.offset.round();

                    if (indexOffset != 0) {
                      controller.tabController
                          .animateTo(controller.tabController.index + indexOffset);
                    } else {
                      final offset = controller.tabController.offset;
                      final animation = AnimationController(
                        vsync: this,
                        value: offset,
                        lowerBound: -1.0,
                        duration: kTabScrollDuration * offset.abs(),
                        reverseDuration: kTabScrollDuration * offset.abs(),
                      );

                      void onAnimation() {
                        controller.tabController.offset = animation.value;
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
                  child: const PrescriptionForm(),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAnimalField() {
    return StreamBuilder<AnimalRead?>(
        stream: controller.animalState,
        builder: (_, data) {
          final animal = data.data;
          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: controller.onAnimalPressed,
            child: FormEditCard(
              [
                EditCardData(
                  label: StringRes.current.prescriptionAnimal,
                  enabled: false,
                  content: animal != null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildAnimalTitle(animal),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 8.0, thickness: 1.0),
                          ],
                        )
                      : null,
                )
              ],
            ),
          );
        });
  }

  Widget _buildAnimalTitle(AnimalRead animal) {
    final avatarUrl = animal.avatar?.image?.small;
    return Row(
      children: [
        if (avatarUrl != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
              radius: 20.0,
            ),
          ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: animal.name,
                  style: StyleRes.subTitle,
                ),
                const TextSpan(
                  text: ', ',
                  style: StyleRes.subTitle,
                ),
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

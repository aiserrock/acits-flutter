import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

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
    Key? key,
  }) : super(key: key);

  final int? editPrescriptionId;
  final Prescription? editPrescription;

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
          StreamBuilder<AnimalRead?>(
              stream: controller.animalState,
              builder: (_, data) {
                final animal = data.data;
                return _buildAnimalField(animal);
              }),
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
                      // ignore: prefer_function_declarations_over_variables
                      final VoidCallback onAnimation = () {
                        controller.tabController.offset = animation.value;
                      };
                      animation.addListener(onAnimation);
                      animation.addStatusListener((status) {
                        if (status == AnimationStatus.completed) {
                          animation.removeListener(onAnimation);
                        }
                      });
                      animation.animateTo(.0, duration: kTabScrollDuration);
                    }
                  },
                  child: const TreatmentForm(),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAnimalField(AnimalRead? animal) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: controller.onAnimalPressed,
      child: FormEditCard(
        [
          EditCardData(
            label: 'Animal*',
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
  }

  Widget _buildAnimalTitle(AnimalRead animal) {
    return Text.rich(
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
    );
  }
}

class TreatmentForm extends StatelessWidget {
  const TreatmentForm({Key? key}) : super(key: key);

  PrescriptionEditScreenController get controller => PrescriptionEditScreenController.controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: StreamBuilder<MyTypeEnum>(
          stream: controller.typeState,
          builder: (_, typeSnapshot) {
            final type = typeSnapshot.data;
            return Column(
              children: [
                if (type == MyTypeEnum.courseOfTreatment) _buildPeriodSelector(),
                StreamBuilder<TreatmentPeriod>(
                    stream: controller.treatmentPeriodState,
                    builder: (_, data) {
                      final periodData = data.data;
                      return _periodForm(
                        context,
                        periodData,
                      );
                    }),
                _buildDrugList(),
                FormEditCard(
                  [
                    EditCardData(
                      label: 'Comment',
                    ),
                  ],
                ),
                const SizedBox(height: 64.0),
              ],
            );
          }),
    );
  }

  Widget _buildDrugList() {
    return StreamBuilder<List<PrescriptionDrug>>(
        initialData: const [],
        stream: controller.drugsState,
        builder: (_, drugList) {
          return Form(
            key: controller.drugFormKey,
            child: FormEditCard(
              [
                ...(drugList.data ?? []).mapIndexed<EditCardData>(
                  (index, drug) => EditCardData(
                    initValue: '${drug.drugName}, ${drug.formOfDrug}, ${drug.drugDosage}',
                    suffix: const Icon(
                      Icons.remove_circle_outline_rounded,
                      color: ColorRes.error,
                    ),
                    onPressed: () => controller.removeDrug(index),
                  ),
                ),
                EditCardData(
                  label: 'Drug*',
                  suffix: const Icon(
                    Icons.menu_open_rounded,
                    color: ColorRes.accent,
                  ),
                  onPressed: () => controller.pickDrug(),
                  validator: (_) => drugList.data?.isEmpty ?? true ? '' : null,
                ),
              ],
              key: UniqueKey(),
            ),
          );
        });
  }

  Widget _periodForm(
    BuildContext context,
    TreatmentPeriod? data,
  ) {
    return StreamBuilder<List<DateTime>>(
        initialData: const [],
        stream: controller.daysListState,
        builder: (_, daysData) {
          return StreamBuilder<List<TimeOfDay>>(
              initialData: const [],
              stream: controller.atTimeListState,
              builder: (_, timesData) {
                return Form(
                  key: controller.dateTimeFormKey,
                  child: FormEditCard(
                    [
                      ...(daysData.data ?? []).mapIndexed<EditCardData>(
                        (index, date) => EditCardData(
                          initValue: date.toDateShortWeekDay,
                          suffix: const Icon(
                            Icons.remove_circle_outline_rounded,
                            color: ColorRes.error,
                          ),
                          onPressed: () => controller.removeDate(index),
                        ),
                      ),
                      EditCardData(
                        label: 'Date${daysData.data?.isNotEmpty ?? false ? '+' : '*'}',
                        suffix: const Icon(
                          Icons.calendar_today_outlined,
                          color: ColorRes.accent,
                        ),
                        onPressed: () => controller.pickStartDate(context),
                        validator: (_) => daysData.data?.isEmpty ?? true ? '' : null,
                      ),
                      ...(timesData.data ?? []).mapIndexed<EditCardData>(
                        (index, time) => EditCardData(
                          initValue: time.format(context),
                          suffix: const Icon(
                            Icons.remove_circle_outline_rounded,
                            color: ColorRes.error,
                          ),
                          onPressed: () => controller.removeTime(index),
                        ),
                      ),
                      EditCardData(
                        label: 'At time${timesData.data?.isNotEmpty ?? false ? '+' : '*'}',
                        onPressed: () => controller.pickAtTime(context, 0),
                        validator: (_) => timesData.data?.isEmpty ?? true ? '' : null,
                        suffix: const Icon(
                          Icons.watch_later_outlined,
                          color: ColorRes.accent,
                        ),
                      ),
                    ],
                    key: UniqueKey(),
                  ),
                );
              });
        });
  }

  Widget _buildPeriodSelector() {
    return StreamBuilder<TreatmentPeriod>(
        stream: controller.treatmentPeriodState,
        builder: (_, data) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl(
                groupValue: data.data,
                children: const <TreatmentPeriod, Widget>{
                  TreatmentPeriod.daily: Text('Daily'),
                  TreatmentPeriod.weekly: Text('Weekly'),
                  TreatmentPeriod.date: Text('Choose date'),
                },
                onValueChanged: controller.onTreatmentPeriodChanged,
              ),
            ),
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/screen/prescription/prescription_edit_screen_controller.dart';

const _maxCommentLength = 1024;

/// Виджет ввода данных назначения
class PrescriptionForm extends StatelessWidget {
  const PrescriptionForm({Key? key}) : super(key: key);

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
                StreamBuilder<MyTypeEnum>(
                  stream: controller.typeState,
                  builder: (_, type) => type.data.hasDrugs ? _buildDrugList() : const SizedBox(),
                ),
                FormEditCard(
                  [
                    EditCardData(
                      controller: controller.commentContoroller,
                      label: StringRes.current.prescriptionComment,
                      maxLength: _maxCommentLength,
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
                  label:
                      '${StringRes.current.prescriptionDrug}${drugList.data?.isNotEmpty ?? false ? '+' : '*'}',
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
                      if (controller.allowMultiDate || (daysData.data ?? []).isEmpty)
                        EditCardData(
                          label:
                              '${StringRes.current.prescriptionDate}${daysData.data?.isNotEmpty ?? false ? '+' : '*'}',
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
                      if (controller.allowMultiTime || (timesData.data ?? []).isEmpty)
                        EditCardData(
                          label:
                              '${StringRes.current.prescriptionTime}${timesData.data?.isNotEmpty ?? false ? '+' : '*'}',
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
                children: <TreatmentPeriod, Widget>{
                  TreatmentPeriod.daily: Text(StringRes.current.prescriptionDaily),
                  TreatmentPeriod.weekly: Text(StringRes.current.prescriptionWeekly),
                },
                onValueChanged: controller.onTreatmentPeriodChanged,
              ),
            ),
          );
        });
  }
}

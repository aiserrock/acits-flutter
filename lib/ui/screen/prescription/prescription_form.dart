import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/screen/prescription/cubit/prescription_edit_cubit.dart';
import 'package:acits_flutter/ui/screen/prescription/cubit/prescription_edit_state.dart';

const _maxCommentLength = 1024;

/// Виджет ввода данных назначения
class PrescriptionForm extends StatelessWidget {
  const PrescriptionForm({required this.commentContoroller, super.key});

  /// Контроллер поля комментария (владелец — State экрана).
  final TextEditingController commentContoroller;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PrescriptionEditCubit>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child:
          BlocSelector<PrescriptionEditCubit, PrescriptionEditState, PrescriptionShortMyTypeEnum?>(
            selector: (state) => state.type,
            builder: (_, type) {
              return Column(
                children: [
                  if (type == PrescriptionShortMyTypeEnum.courseOfTreatment)
                    _buildPeriodSelector(cubit),
                  BlocSelector<PrescriptionEditCubit, PrescriptionEditState, TreatmentPeriod>(
                    selector: (state) => state.treatmentPeriod,
                    builder: (_, periodData) => _periodForm(context, cubit, periodData),
                  ),
                  type.hasDrugs ? _buildDrugList(context, cubit) : const SizedBox(),
                  FormEditCard([
                    EditCardData(
                      controller: commentContoroller,
                      label: LocaleKeys.prescriptionComment.tr(),
                      maxLength: _maxCommentLength,
                    ),
                  ]),
                  const SizedBox(height: 64.0),
                ],
              );
            },
          ),
    );
  }

  Widget _buildDrugList(BuildContext context, PrescriptionEditCubit cubit) {
    return BlocSelector<PrescriptionEditCubit, PrescriptionEditState, List<PrescriptionDrug>>(
      selector: (state) => state.drugs,
      builder: (context, drugList) {
        return Form(
          key: cubit.drugFormKey,
          child: FormEditCard(
            [
              ...drugList.mapIndexed<EditCardData>(
                (index, drug) => EditCardData(
                  initValue: '${drug.drugName}, ${drug.formOfDrug}, ${drug.drugDosage}',
                  suffix: const Icon(Icons.remove_circle_outline_rounded, color: ColorRes.error),
                  onPressed: () => cubit.removeDrug(index),
                ),
              ),
              EditCardData(
                label: '${LocaleKeys.prescriptionDrug.tr()}${drugList.isNotEmpty ? '+' : '*'}',
                suffix: const Icon(Icons.menu_open_rounded, color: ColorRes.accent),
                onPressed: () => cubit.pickDrug(context),
                validator: (_) => drugList.isEmpty ? '' : null,
              ),
              // Ключ зависит от состава списка (а не UniqueKey на каждый ребилд):
              // read-only TextFormField'ы держат initialValue в своём контроллере
              // и не обновляются при переиспользовании Element — поэтому форму
              // пересобираем ровно при изменении набора препаратов, не чаще.
            ],
            key: ValueKey(
              'drugs:${drugList.map((d) => '${d.drugName}/${d.drugDosage}').join(',')}',
            ),
          ),
        );
      },
    );
  }

  Widget _periodForm(BuildContext context, PrescriptionEditCubit cubit, TreatmentPeriod? data) {
    return BlocBuilder<PrescriptionEditCubit, PrescriptionEditState>(
      buildWhen: (prev, next) =>
          prev.daysList != next.daysList ||
          prev.atTimeList != next.atTimeList ||
          prev.type != next.type,
      builder: (_, state) {
        final daysData = state.daysList;
        final timesData = state.atTimeList;
        return Form(
          key: cubit.dateTimeFormKey,
          child: FormEditCard(
            [
              ...daysData.mapIndexed<EditCardData>(
                (index, date) => EditCardData(
                  initValue: date.toDateShortWeekDay,
                  suffix: const Icon(Icons.remove_circle_outline_rounded, color: ColorRes.error),
                  onPressed: () => cubit.removeDate(index),
                ),
              ),
              if (cubit.allowMultiDate || daysData.isEmpty)
                EditCardData(
                  label: '${LocaleKeys.prescriptionDate.tr()}${daysData.isNotEmpty ? '+' : '*'}',
                  suffix: const Icon(Icons.calendar_today_outlined, color: ColorRes.accent),
                  onPressed: () => cubit.pickStartDate(context),
                  validator: (_) => daysData.isEmpty ? '' : null,
                ),
              ...timesData.mapIndexed<EditCardData>(
                (index, time) => EditCardData(
                  initValue: time.format(context),
                  suffix: const Icon(Icons.remove_circle_outline_rounded, color: ColorRes.error),
                  onPressed: () => cubit.removeTime(index),
                ),
              ),
              if (cubit.allowMultiTime || timesData.isEmpty)
                EditCardData(
                  label: '${LocaleKeys.prescriptionTime.tr()}${timesData.isNotEmpty ? '+' : '*'}',
                  onPressed: () => cubit.pickAtTime(context, 0),
                  validator: (_) => timesData.isEmpty ? '' : null,
                  suffix: const Icon(Icons.watch_later_outlined, color: ColorRes.accent),
                ),
              // Ключ по составу дат/времён — форма пересобирается при изменении
              // набора, а не на каждый ребилд (см. пояснение в _buildDrugList).
            ],
            key: ValueKey(
              'period:${daysData.join(',')}|${timesData.map((t) => '${t.hour}:${t.minute}').join(',')}',
            ),
          ),
        );
      },
    );
  }

  Widget _buildPeriodSelector(PrescriptionEditCubit cubit) {
    return BlocSelector<PrescriptionEditCubit, PrescriptionEditState, TreatmentPeriod>(
      selector: (state) => state.treatmentPeriod,
      builder: (_, period) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl(
              groupValue: period,
              children: <TreatmentPeriod, Widget>{
                TreatmentPeriod.daily: Text(LocaleKeys.prescriptionDaily.tr()),
                TreatmentPeriod.weekly: Text(LocaleKeys.prescriptionWeekly.tr()),
              },
              onValueChanged: cubit.onTreatmentPeriodChanged,
            ),
          ),
        );
      },
    );
  }
}

import 'package:acits_core/acits_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/prescription.dart';
import '../../../domain/prescription_animal_ref.dart';
import '../../../domain/prescription_drug.dart';
import '../../../domain/prescription_type.dart';
import 'prescription_edit_cubit.dart';

/// Сентинел для copyWith: отличает «параметр не передан» от явного сброса
/// nullable-поля в null (иначе `animal ?? this.animal` не давал снять выбор).
const Object _unset = Object();

/// Состояние экрана создания/редактирования назначения.
///
/// Сворачивает восемь бывших [BehaviorSubject] контроллера в один
/// иммутабельный объект: состояние данных назначения ([screen]), выбранное
/// животное ([animal]), тип назначения ([type]), периодичность
/// ([treatmentPeriod]), список дат ([daysList]) и времён ([atTimeList]),
/// список лекарств ([drugs]) и флаг фоновой загрузки ([loading]).
/// UI-контроллеры ([TabController], [TextEditingController]) остаются во
/// [StatefulWidget] экрана.
class PrescriptionEditState extends Equatable {
  const PrescriptionEditState({
    this.screen = const DataState.content(null),
    this.animal,
    this.type,
    this.treatmentPeriod = TreatmentPeriod.daily,
    this.atTimeList = const [],
    this.daysList = const [],
    this.drugs = const [],
    this.loading = false,
  });

  /// Состояние данных назначения (загрузка/контент/ошибка) для режима
  /// редактирования и отправки формы.
  final DataState<Prescription?> screen;

  /// Выбранное животное.
  final PrescriptionAnimalRef? animal;

  /// Тип назначения (соответствует выбранной вкладке).
  final PrescriptionType? type;

  /// Тип периодичности назначения (ежедневно | еженедельно).
  final TreatmentPeriod treatmentPeriod;

  /// Время назначения.
  final List<TimeOfDay> atTimeList;

  /// Даты назначения.
  final List<DateTime> daysList;

  /// Список лекарств и дозировок.
  final List<PrescriptionDrug> drugs;

  /// Идёт ли фоновая загрузка (спиннер над формой).
  final bool loading;

  PrescriptionEditState copyWith({
    DataState<Prescription?>? screen,
    Object? animal = _unset,
    Object? type = _unset,
    TreatmentPeriod? treatmentPeriod,
    List<TimeOfDay>? atTimeList,
    List<DateTime>? daysList,
    List<PrescriptionDrug>? drugs,
    bool? loading,
  }) {
    return PrescriptionEditState(
      screen: screen ?? this.screen,
      // animal/type: _unset → оставить текущее; иначе заменить (в т.ч. на null,
      // чтобы можно было снять выбранное животное/тип).
      animal: identical(animal, _unset) ? this.animal : animal as PrescriptionAnimalRef?,
      type: identical(type, _unset) ? this.type : type as PrescriptionType?,
      treatmentPeriod: treatmentPeriod ?? this.treatmentPeriod,
      atTimeList: atTimeList ?? this.atTimeList,
      daysList: daysList ?? this.daysList,
      drugs: drugs ?? this.drugs,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [screen, animal, type, treatmentPeriod, atTimeList, daysList, drugs, loading];
}

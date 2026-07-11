import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/prescription_model.dart';
import 'package:acits_flutter/ui/screen/prescription/cubit/prescription_edit_cubit.dart';

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
  final DataState<PrescriptionModel?> screen;

  /// Выбранное животное.
  final AnimalRead? animal;

  /// Тип назначения (соответствует выбранной вкладке).
  final PrescriptionShortMyTypeEnum? type;

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
    DataState<PrescriptionModel?>? screen,
    AnimalRead? animal,
    PrescriptionShortMyTypeEnum? type,
    TreatmentPeriod? treatmentPeriod,
    List<TimeOfDay>? atTimeList,
    List<DateTime>? daysList,
    List<PrescriptionDrug>? drugs,
    bool? loading,
  }) {
    return PrescriptionEditState(
      screen: screen ?? this.screen,
      animal: animal ?? this.animal,
      type: type ?? this.type,
      treatmentPeriod: treatmentPeriod ?? this.treatmentPeriod,
      atTimeList: atTimeList ?? this.atTimeList,
      daysList: daysList ?? this.daysList,
      drugs: drugs ?? this.drugs,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
    screen,
    animal,
    type,
    treatmentPeriod,
    atTimeList,
    daysList,
    drugs,
    loading,
  ];
}

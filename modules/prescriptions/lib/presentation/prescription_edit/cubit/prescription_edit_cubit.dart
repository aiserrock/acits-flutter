// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:l10n/acits_l10n.dart';

import 'package:base/base.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:prescriptions/data/data.dart';
import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/presentation/presentation.dart';
import 'package:prescriptions/util/util.dart';

const _shiftFirtsStartDate = Duration(days: 30);
const _shiftLastStartDate = Duration(days: 120);

/// Cubit экрана создания/редактирования назначения.
///
/// Владеет всем бизнес-состоянием ([PrescriptionEditState]) и логикой
/// (загрузка по id, сборка и отправка назначения, добавление/удаление
/// лекарств, выбор животного/лекарства через поиск, пикеры дат/времени,
/// bottom-sheet дозировки). UI-контроллеры ([TabController],
/// [TextEditingController]) остаются во [StatefulWidget] экрана.
///
/// Зависимости инъектятся через конструктор: сервис назначений, порт навигации
/// (поиск животного/препарата), порт загрузки животного (мостится к
/// `AnimalRepository`), порт имён типов и ключ ScaffoldMessenger приложения.
class PrescriptionEditCubit extends Cubit<PrescriptionEditState> {
  PrescriptionEditCubit(
    this._prescriptionService,
    this._router,
    this._animalLoader,
    this._typeLabels,
    this._scaffoldMessengerKey, {
    this.editPrescriptionId,
    this.editPrescription,
    PrescriptionAnimalRef? initAnimal,
    int? initAnimalId,
  }) : super(PrescriptionEditState(animal: initAnimal, type: _filteredTypes[_initialTabIndex(editPrescription)])) {
    // Strangler-шов: карточка животного мигрирована на модуль animals. Для
    // preset-животного при создании назначения экран приходит с id —
    // подгружаем сущность через порт загрузки (не chopper).
    if (initAnimal == null && initAnimalId != null) _loadInitAnimal(initAnimalId);
  }

  /// Типы без служебного [PrescriptionType.unknown] — в том же порядке, что и
  /// табы на экране (см. [getTypes]).
  static final List<PrescriptionType> _filteredTypes = PrescriptionType.selectable;

  /// Индекс начального типа в ОТФИЛЬТРОВАННОМ списке [_filteredTypes]
  /// (совпадает с индексом таба).
  static int _initialTabIndex(Prescription? editPrescription) {
    final type = editPrescription?.type;
    if (type == null) return 0;
    return max(_filteredTypes.indexOf(type), 0);
  }

  final int? editPrescriptionId;
  final Prescription? editPrescription;
  final PrescriptionService _prescriptionService;
  final PrescriptionsRouterService _router;
  final PrescriptionAnimalLoader _animalLoader;
  final PrescriptionTypeLabels _typeLabels;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  final dateTimeFormKey = GlobalKey<FormState>();
  final drugFormKey = GlobalKey<FormState>();

  /// Является ли данный экран Редактированием назначения (по дефолту - false,
  /// Создание нового).
  bool get isEdit => editPrescription != null || editPrescriptionId != null;

  /// Отправка формы: собирает [Prescription] и создаёт/обновляет назначение.
  ///
  /// Возвращает сохранённое [Prescription] при успехе, либо `null` (ошибка
  /// показана через [state]) — виджет закрывает экран с результатом.
  Future<Prescription?> submit({required String description, required BuildContext context}) async {
    if (_checkIsLoading) return null;
    Log.debug('PrescriptionEditCubit.submit isEdit=$isEdit');

    final animalId = state.animal?.id;
    if (animalId == null) {
      _showError(LocaleKeys.prescriptionPickAnimalMsg.tr());
      return null;
    }
    if (!(dateTimeFormKey.currentState?.validate() ?? false)) return null;
    if (state.type.hasDrugs && !(drugFormKey.currentState?.validate() ?? false)) return null;

    final data = Prescription(
      id: editPrescription?.id ?? editPrescriptionId,
      animal: animalId,
      type: state.type ?? PrescriptionType.unknown,
      description: description,
      drugs: state.drugs,
      duration: state.type == PrescriptionType.courseOfTreatment && state.treatmentPeriod == TreatmentPeriod.weekly
          ? PrescriptionDuration.everyWeek
          : PrescriptionDuration.custom,
      executions: [
        ...state.daysList
            .map<Iterable<PrescriptionExecution>>(
              (day) => state.atTimeList.map((time) => PrescriptionExecution(executeAt: day.mergeTime(time))),
            )
            .expand((list) => list),
      ],
    );

    safeEmit(state.copyWith(screen: const DataState.loading()));
    try {
      final result = isEdit
          ? await _prescriptionService.updatePrescription(data)
          : await _prescriptionService.createPrescription(data);
      Log.info('PrescriptionEditCubit.submit ok: id=${result.id}');
      safeEmit(state.copyWith(screen: DataState.content(result)));
      return result;
    } catch (e, s) {
      Log.error('PrescriptionEditCubit.submit failed', e, s);
      safeEmit(state.copyWith(screen: DataState.error(e)));
      return null;
    }
  }

  List<PrescriptionType> getTypes() => _filteredTypes;

  List<String> getTabs() {
    return getTypes().map<String>((type) => _typeLabels.nameForWire(type.wire) ?? '').toList();
  }

  /// Можно ли установить несколько дат для данного типа назначения.
  bool get allowMultiDate => state.type.allowMultiDate;

  /// Можно ли установить время несколько время для данного типа назначения.
  bool get allowMultiTime => state.type.allowMultiTime;

  bool get _checkIsLoading {
    if (state.loading) {
      _showError(LocaleKeys.prescriptionWaitLoadingMsg.tr());
    }
    return state.loading;
  }

  /// Подгружает preset-животное по id (создание назначения из карточки).
  Future<void> _loadInitAnimal(int animalId) async {
    final ref = await _animalLoader.loadById(animalId);
    if (ref == null) {
      Log.error('PrescriptionEditCubit._loadInitAnimal failed: id=$animalId');
      return;
    }
    safeEmit(state.copyWith(animal: ref));
  }

  /// Загружает назначение (и животное) в режиме редактирования.
  ///
  /// Возвращает индекс вкладки, на которую нужно перейти (или `null`), чтобы
  /// виджет синхронизировал [TabController]; комментарий возвращается через
  /// колбэк [onComment].
  Future<int?> setEditedState({ValueChanged<String>? onComment}) async {
    Log.debug('PrescriptionEditCubit.setEditedState id=$editPrescriptionId');
    Prescription? prescription;
    final id = editPrescriptionId;
    if (editPrescription != null) {
      prescription = editPrescription;
    } else if (id != null) {
      try {
        prescription = await _prescriptionService.fetchPrescriptionById(id);
      } catch (e, s) {
        Log.error('PrescriptionEditCubit.setEditedState failed', e, s);
        safeEmit(state.copyWith(screen: DataState.error(e)));
      }
    }

    if (prescription == null) return null;

    final animalId = prescription.animal;
    final ref = await _animalLoader.loadById(animalId);
    if (ref == null) {
      Log.error('PrescriptionEditCubit.setEditedState failed: animal load failed id=$animalId');
      safeEmit(state.copyWith(screen: const DataState.error('animal load failed')));
      return null;
    }

    var next = state.copyWith(screen: DataState.content(prescription), animal: ref);

    final drugs = prescription.drugs;
    if (drugs.isNotEmpty) {
      next = next.copyWith(drugs: drugs);
    }

    final executuons = prescription.executions;
    final days = <DateTime>{}
      ..addAll(executuons.map((item) => item.executeAt).map((date) => DateTime(date.year, date.month, date.day)));
    final times = <TimeOfDay>{}
      ..addAll(executuons.map((item) => item.executeAt).map((time) => TimeOfDay(hour: time.hour, minute: time.minute)));

    if (days.isNotEmpty && times.isNotEmpty) {
      next = next.copyWith(daysList: days.toList()..sort(), atTimeList: times.toList()..sort(TimeOfDayX.timeSort));
    }

    final comment = prescription.description;
    if (comment != null) onComment?.call(comment);

    if (prescription.duration == PrescriptionDuration.everyWeek &&
        prescription.type == PrescriptionType.courseOfTreatment) {
      next = next.copyWith(treatmentPeriod: TreatmentPeriod.weekly);
    }

    safeEmit(next);
    Log.info('PrescriptionEditCubit.setEditedState ok: id=${prescription.id}');

    final type = prescription.type;
    final tabIndex = _filteredTypes.indexOf(type);
    return tabIndex >= 0 ? tabIndex : null;
  }

  void onAnimalPressed(BuildContext context) {
    if (isEdit) {
      _showError(LocaleKeys.prescriptionCantChangeAnimalMsg.tr());
      return;
    }
    _router.pickAnimal().then((animal) {
      if (animal != null) {
        safeEmit(state.copyWith(animal: animal));
      }
    });
  }

  void onTreatmentPeriodChanged(TreatmentPeriod? period) {
    if (period == null) return;
    safeEmit(state.copyWith(treatmentPeriod: period));
  }

  Future<void> pickStartDate(BuildContext context) async {
    final now = DateTime.now();
    final dateShift = state.treatmentPeriod == TreatmentPeriod.weekly ? 7 : 1;
    final initDate = state.daysList.isNotEmpty ? state.daysList.max.add(Duration(days: dateShift)) : now;
    final result = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: now.subtract(_shiftFirtsStartDate),
      lastDate: now.add(_shiftLastStartDate),
    );
    if (result != null) {
      safeEmit(
        state.copyWith(
          daysList: List<DateTime>.from(state.daysList)
            ..add(result)
            ..sort(),
        ),
      );
    }
  }

  void removeDate(int index) {
    safeEmit(state.copyWith(daysList: List<DateTime>.from(state.daysList)..removeAt(index)));
  }

  Future<void> pickAtTime(BuildContext context, int index) async {
    final result = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      safeEmit(
        state.copyWith(
          atTimeList: List<TimeOfDay>.from(state.atTimeList)
            ..add(result)
            ..sort(TimeOfDayX.timeSort),
        ),
      );
    }
  }

  void removeTime(int index) {
    safeEmit(state.copyWith(atTimeList: List<TimeOfDay>.from(state.atTimeList)..removeAt(index)));
  }

  Future<void> pickDrug(BuildContext context) async {
    final drug = await _router.pickDrug();
    if (drug == null) return;

    final dosage = await showModalBottomSheet<double>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bsCtx) {
        return BsDosage(drug: drug);
      },
    );

    if (dosage == null) return;

    safeEmit(
      state.copyWith(
        drugs: List<PrescriptionDrug>.from(state.drugs)
          ..add(
            PrescriptionDrug(drugId: drug.id, drugDosage: dosage, drugName: drug.name, formOfDrug: drug.formOfDrugName),
          ),
      ),
    );
  }

  void removeDrug(int index) {
    safeEmit(state.copyWith(drugs: List<PrescriptionDrug>.from(state.drugs)..removeAt(index)));
  }

  /// Обрабатывает смену вкладки: обновляет тип и обрезает лишние даты/времена
  /// для типов, не допускающих множественный выбор.
  void onTabChanged(int index) {
    final type = getTypes()[index];
    var next = state.copyWith(type: type);
    if (!type.allowMultiDate && next.daysList.length > 1) {
      next = next.copyWith(daysList: next.daysList.take(1).toList());
    }
    if (!type.allowMultiTime && next.atTimeList.length > 1) {
      next = next.copyWith(atTimeList: next.atTimeList.take(1).toList());
    }
    safeEmit(next);
  }

  void _showError(String msg) {
    _scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(height: 40.0, width: 40.0, child: LottieBuilder.asset(PrescriptionsLottieRes.crashScratch)),
              Expanded(child: Text(msg)),
            ],
          ),
        ),
      );
  }
}

enum TreatmentPeriod { daily, weekly }

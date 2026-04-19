import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/rxdart.dart';

import 'package:acits_flutter/ui/screen/search_screen/search.dart';
import 'package:acits_flutter/ui/screen/prescription/dosage_bs.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';

const _shiftFirtsStartDate = Duration(days: 30);
const _shiftLastStartDate = Duration(days: 120);

class PrescriptionEditScreenController {
  PrescriptionEditScreenController({
    required this.scaffoldKey,
    required TickerProvider tickerProvider,
    this.editPrescriptionId,
    this.editPrescription,
    AnimalRead? initAnimal,
  })  : tabController = TabController(
          initialIndex: editPrescription?.myType is MyTypeEnum
              ? max(MyTypeEnum.values.indexOf(editPrescription!.myType!), 0)
              : 0,
          length: MyTypeEnum.values.length - 1,
          vsync: tickerProvider,
        ),
        _animalService = getIt<AnimalService>(),
        _configService = getIt<ConfigService>(),
        _scaffoldMessengerKey = getIt<GlobalKey<ScaffoldMessengerState>>(),
        _prescriptionService = getIt<PrescriptionService>() {
    if (isEdit) setEditedState();
    tabController.addListener(_onTabChanged);
    typeState.add(getTypes()[tabController.index]);
    if (initAnimal != null) animalState.add(initAnimal);
  }

  final int? editPrescriptionId;
  final Prescription? editPrescription;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;
  final ConfigService _configService;
  final PrescriptionService _prescriptionService;
  final AnimalService _animalService;
  final TabController tabController;

  final dateTimeFormKey = GlobalKey<FormState>();
  final drugFormKey = GlobalKey<FormState>();

  /// Комментарий
  final commentContoroller = TextEditingController();

  /// Тип назначения
  final typeState = BehaviorSubject<MyTypeEnum>();

  /// Сочтояние загрузки экрана
  final loadingState = BehaviorSubject<bool>.seeded(false);

  /// Состояние данных назначения
  final screenState = BehaviorSubject<WidgetState<Prescription>?>();

  /// Выбранное животное
  final animalState = BehaviorSubject<AnimalRead?>();

  /// Тип периодичности назначения (ежедневно | еженедельно | определенная дата)
  final treatmentPeriodState = BehaviorSubject<TreatmentPeriod>.seeded(TreatmentPeriod.daily);

  /// Время назначения
  final atTimeListState = BehaviorSubject<List<TimeOfDay>>.seeded([]);

  /// Дата назначения
  final daysListState = BehaviorSubject<List<DateTime>>.seeded([]);

  /// Список лекарств и дозировок
  final drugsState = BehaviorSubject<List<PrescriptionDrug>>.seeded([]);

  static PrescriptionEditScreenController get controller =>
      getIt<PrescriptionEditScreenController>();

  /// Является ли данный экран Редактированием назначения (по дефолту - false, Создание нового)
  bool get isEdit => editPrescription != null || editPrescriptionId != null;

  void dispose() {
    loadingState.close();
    screenState.close();
    animalState.close();
    treatmentPeriodState.close();
    atTimeListState.close();
    daysListState.close();
    drugsState.close();
    tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    typeState.close();
  }

  void onFabPressed() {
    if (_checkIsLoading) return;

    final animalId = animalState.valueOrNull?.id;

    if (animalId == null) {
      _showError(StringRes.current.prescriptionPickAnimalMsg);
      return;
    }
    if (!(dateTimeFormKey.currentState?.validate() ?? false)) return;
    if (typeState.value.hasDrugs && !(drugFormKey.currentState?.validate() ?? false)) return;

    screenState.add(WidgetState()..loading());
    final data = Prescription(
      id: editPrescription?.id ?? editPrescriptionId,
      animal: animalId,
      myType: typeState.value,
      description: commentContoroller.text,
      drugs: drugsState.valueOrNull,
      duration: typeState.valueOrNull == MyTypeEnum.courseOfTreatment &&
              treatmentPeriodState.valueOrNull == TreatmentPeriod.weekly
          ? DurationEnum.everyWeek
          : DurationEnum.custom,
      executions: [
        ...daysListState.value
            .map<Iterable<PrescriptionExecution>>(
              (day) => atTimeListState.value.map(
                (time) => PrescriptionExecution(
                  executeAt: day.mergeTime(time),
                ),
              ),
            )
            .expand((list) => list)
      ],
    );

    final ctx = _context;
    if (ctx == null) return;

    screenState.add(WidgetState()..loading());
    if (isEdit) {
      _prescriptionService.updatePrescription(data).then((result) {
        Navigator.of(ctx).pop(result);
      }).catchError((e) {
        screenState.add(WidgetState()..error = e);
      });
    } else {
      _prescriptionService.createPrescription(data).then((result) {
        Navigator.of(ctx).pop(result);
      }).catchError((e) {
        screenState.add(WidgetState()..error = e);
      });
    }
  }

  List<MyTypeEnum> getTypes() {
    return MyTypeEnum.values.where((type) => type != MyTypeEnum.swaggerGeneratedUnknown).toList();
  }

  List<String> getTabs() {
    return getTypes().map<String>((type) => _configService.getMyTypeName(type) ?? '').toList();
  }

  /// Можно ли установить несколько дат для данного типа назначения
  bool get allowMultiDate => typeState.value.allowMultiDate;

  /// Можно ли установить время несколько время для данного типа назначения
  bool get allowMultiTime => typeState.value.allowMultiTime;

  bool get _checkIsLoading {
    if (loadingState.value) {
      _showError(StringRes.current.prescriptionWaitLoadingMsg);
    }
    return loadingState.value;
  }

  Future<void> setEditedState() async {
    Prescription? prescription;
    final id = editPrescriptionId;
    if (editPrescription != null) {
      prescription = editPrescription;
    } else if (id != null) {
      prescription = await _prescriptionService.fetchPrescriptionById(id).catchError(
        (e) {
          screenState.add(WidgetState()..error = e);
        },
      );
    }

    if (prescription != null) {
      final animalId = prescription.animal;
      if (animalId == null) return;
      final animal = await _animalService.fetchAnimalDetail(id: animalId).catchError(
        (e) {
          screenState.add(WidgetState()..error = e);
        },
      );

      screenState.add(WidgetState(prescription));
      final type = prescription.myType;
      final tabIndex = type != null ? MyTypeEnum.values.indexOf(type) : -1;
      if (tabIndex >= 0) tabController.animateTo(tabIndex - 1);
      animalState.add(animal);

      final drugs = prescription.drugs;
      if (drugs != null && drugs.isNotEmpty) {
        drugsState.add(drugs);
      }

      final executuons = prescription.executions;
      if (executuons != null) {
        final days = <DateTime>{}..addAll(
            executuons.map((item) => item.executeAt).whereNotNull().map(
                  (date) => DateTime(
                    date.year,
                    date.month,
                    date.day,
                  ),
                ),
          );
        final times = <TimeOfDay>{}..addAll(
            executuons.map((item) => item.executeAt).whereNotNull().map(
                  (time) => TimeOfDay(
                    hour: time.hour,
                    minute: time.minute,
                  ),
                ),
          );

        if (days.isNotEmpty && times.isNotEmpty) {
          daysListState.add(days.toList()..sort());
          atTimeListState.add(times.toList()..sort(TimeOfDayX.timeSort));
        }
      }

      final comment = prescription.description;
      if (comment != null) {
        commentContoroller.text = comment;
      }

      if (prescription.duration == DurationEnum.everyWeek &&
          prescription.myType == MyTypeEnum.courseOfTreatment) {
        treatmentPeriodState.add(TreatmentPeriod.weekly);
      }
    }
  }

  void onAnimalPressed() {
    if (isEdit) {
      _showError(StringRes.current.prescriptionCantChangeAnimalMsg);
      return;
    }
    final ctx = _context;
    if (ctx == null) return;
    Navigator.of(ctx).push(Search.route<AnimalRead>()).then(
      (animal) {
        if (animal != null) {
          animalState.add(animal);
        }
      },
    );
  }

  void onTreatmentPeriodChanged(TreatmentPeriod? period) {
    if (period == null) return;
    treatmentPeriodState.add(period);
  }

  void pickStartDate(BuildContext context) async {
    final now = DateTime.now();
    final dateShift = treatmentPeriodState.value == TreatmentPeriod.weekly ? 7 : 1;
    final initDate = daysListState.value.isNotEmpty
        ? daysListState.value.max.add(Duration(days: dateShift))
        : now;
    final result = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: now.subtract(_shiftFirtsStartDate),
      lastDate: now.add(_shiftLastStartDate),
    );
    if (result != null) {
      daysListState.add(daysListState.value
        ..add(result)
        ..sort());
    }
  }

  void removeDate(int index) {
    daysListState.add(daysListState.value..removeAt(index));
  }

  void pickAtTime(
    BuildContext context,
    int index,
  ) async {
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result != null) {
      atTimeListState.add(
        atTimeListState.value
          ..add(result)
          ..sort(TimeOfDayX.timeSort),
      );
    }
  }

  void removeTime(int index) {
    atTimeListState.add(atTimeListState.value..removeAt(index));
  }

  void pickDrug() async {
    final ctx = _context;
    if (ctx == null) return;

    final drug = await Navigator.of(ctx).push(Search.route<ShelterDrug>());

    if (drug == null) return;

    final dosage = await showModalBottomSheet<double>(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (bsCtx) {
        return BsDosage(drug: drug);
      },
    );

    if (dosage == null) return;

    drugsState.add(
      drugsState.value
        ..add(
          PrescriptionDrug(
            drugId: drug.drug?.id,
            drugDosage: dosage,
            drugName: drug.drug?.name,
            formOfDrug: drug.drug?.formOfDrugName,
          ),
        ),
    );
  }

  void removeDrug(int index) {
    drugsState.add(drugsState.value..removeAt(index));
  }

  void _onTabChanged() {
    typeState.add(getTypes()[tabController.index]);
    if (!allowMultiDate && daysListState.value.length > 1) {
      daysListState.add(daysListState.value.take(1).toList());
    }
    if (!allowMultiTime && atTimeListState.value.length > 1) {
      atTimeListState.add(atTimeListState.value.take(1).toList());
    }
  }

  void _showError(String msg) {
    _scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Row(
        children: [
          SizedBox(
            height: 40.0,
            width: 40.0,
            child: LottieBuilder.asset(LottieRes.crashScratch),
          ),
          Expanded(child: Text(msg)),
        ],
      )));
  }

  BuildContext? get _context => scaffoldKey.currentContext;
}

enum TreatmentPeriod {
  daily,
  weekly,
}

extension MyTypeEnumX on MyTypeEnum? {
  /// Нужны ли лекарства для данного типа назначения
  bool get hasDrugs =>
      this == MyTypeEnum.courseOfTreatment ||
      this == MyTypeEnum.removingStitches ||
      this == MyTypeEnum.woundHealing;

  /// Можно ли установить несколько дат для данного типа назначения
  bool get allowMultiDate => this == MyTypeEnum.courseOfTreatment;

  /// Можно ли установить время несколько время для данного типа назначения
  bool get allowMultiTime => this == MyTypeEnum.courseOfTreatment;
}

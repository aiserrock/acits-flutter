import 'dart:math';

import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_animal_screen_route.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_drug_screen_route.dart';

const _shiftFirtsStartDate = Duration(days: 30);
const _shiftLastStartDate = Duration(days: 120);

class PrescriptionEditScreenController {
  PrescriptionEditScreenController({
    required this.scaffoldKey,
    required TickerProvider tickerProvider,
    this.editPrescriptionId,
    this.editPrescription,
  })  : tabController = TabController(
          initialIndex: editPrescription?.myType is MyTypeEnum
              ? max(MyTypeEnum.values.indexOf(editPrescription!.myType!), 0)
              : 0,
          length: MyTypeEnum.values.length - 1,
          vsync: tickerProvider,
        ),
        _animalService = getIt<AnimalService>(),
        _configService = getIt<ConfigService>(),
        _prescriptionService = getIt<PrescriptionService>() {
    if (isEdit) setEditedState();
    tabController.addListener(_onTabChanged);
    typeState.add(getTypes()[tabController.index]);
  }

  final int? editPrescriptionId;
  final Prescription? editPrescription;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ConfigService _configService;
  final PrescriptionService _prescriptionService;
  final AnimalService _animalService;
  final TabController tabController;

  final dateTimeFormKey = GlobalKey<FormState>();
  final drugFormKey = GlobalKey<FormState>();

  /// Дата начала процедур
  // final startDateContoroller = TextEditingController();
  final drugDosageContoroller = TextEditingController();

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
    loadingState.add(true);
    Future.delayed(const Duration(seconds: 3), () => loadingState.add(false));

    dateTimeFormKey.currentState?.validate();
    drugFormKey.currentState?.validate();
  }

  List<MyTypeEnum> getTypes() {
    return MyTypeEnum.values.where((type) => type != MyTypeEnum.swaggerGeneratedUnknown).toList();
  }

  List<String> getTabs() {
    return getTypes().map<String>((type) => _configService.getMyTypeName(type) ?? '').toList();
  }

  bool get _checkIsLoading {
    if (loadingState.value) {
      _showError('Wait when loading is done please.');
    }
    return loadingState.value;
  }

  Future<void> setEditedState() async {
    if (editPrescription != null) {
      screenState.add(WidgetState(editPrescription));
      return;
    }
    final id = editPrescriptionId;
    if (id != null) {
      screenState.add(WidgetState()..loading());
      final prescription = await _prescriptionService.fetchPrescriptionById(id).catchError(
        (e) {
          screenState.add(WidgetState()..error = e);
        },
      );

      final animalId = prescription?.animal;
      if (animalId == null) return;
      final animal = await _animalService.fetchAnimalDetail(id: animalId).catchError(
        (e) {
          screenState.add(WidgetState()..error = e);
        },
      );

      screenState.add(WidgetState(prescription));
      final type = prescription?.myType;
      final tabIndex = type != null ? MyTypeEnum.values.indexOf(type) : -1;
      if (tabIndex >= 0) tabController.animateTo(tabIndex - 1);
      animalState.add(animal);
    }
  }

  void onAnimalPressed() {
    if (isEdit) {
      _showError('Can\'t change animal when editing prescription');
      return;
    }
    final ctx = _context;
    if (ctx == null) return;
    Navigator.of(ctx).push(SearchAnimalScreenRoute()).then(
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

    final drug = await Navigator.of(ctx).push(SearchDrugScreenRoute());

    if (drug == null) return;

    final dosage = await showModalBottomSheet<double>(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (bsCtx) {
        final controller = TextEditingController();
        onSubmit() {
          final parsed = double.tryParse(controller.text);
          if (parsed == null) {
            return;
          } else {}
          Navigator.of(bsCtx).pop(parsed);
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: ColorRes.foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    '${drug.drug?.name}, ${drug.drug?.formOfDrugName}',
                    style: StyleRes.subTitle,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Dosage*'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onEditingComplete: onSubmit,
                  ),
                  const SizedBox(height: 24.0),
                  PrimaryButton(
                    text: 'Принять',
                    onPressed: onSubmit,
                  )
                ],
              ),
            ),
          ),
        );
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
  }

  void _showError(String msg) {
    scaffoldKey.currentState
      //ignore: deprecated_member_use
      ?..hideCurrentSnackBar()
      //ignore: deprecated_member_use
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  BuildContext? get _context => scaffoldKey.currentContext;
}

enum TreatmentPeriod {
  daily,
  weekly,
  date,
}

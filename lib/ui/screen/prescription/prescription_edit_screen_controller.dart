import 'dart:math';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_animal_screen_route.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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
  }

  final int? editPrescriptionId;
  final Prescription? editPrescription;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ConfigService _configService;
  final PrescriptionService _prescriptionService;
  final AnimalService _animalService;
  final TabController tabController;

  final startDateContoroller = TextEditingController();
  final drugDosageContoroller = TextEditingController();

  final loadingState = BehaviorSubject<bool>.seeded(false);
  final screenState = BehaviorSubject<WidgetState<Prescription>?>();
  final animalState = BehaviorSubject<AnimalRead?>();
  final treatmentPeriodState = BehaviorSubject<TreatmentPeriod>.seeded(TreatmentPeriod.daily);
  final atTimeListState = BehaviorSubject<List<TimeOfDay>>.seeded([]);

  static PrescriptionEditScreenController get controller =>
      getIt<PrescriptionEditScreenController>();

  bool get isEdit => editPrescription != null || editPrescriptionId != null;

  void onFabPressed() {
    if (_checkIsLoading) return;
    loadingState.add(true);
    Future.delayed(const Duration(seconds: 3), () => loadingState.add(false));
  }

  List<String> getTabs() {
    return MyTypeEnum.values
        .where((type) => type != MyTypeEnum.swaggerGeneratedUnknown)
        .map<String>((type) => _configService.getMyTypeName(type) ?? '')
        .toList();
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
    final result = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(_shiftFirtsStartDate),
      lastDate: now.add(_shiftLastStartDate),
    );
    if (result != null) {
      startDateContoroller.text = result.toDateShortOnly;
    }
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
      atTimeListState.add(atTimeListState.value..add(result));
    }
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

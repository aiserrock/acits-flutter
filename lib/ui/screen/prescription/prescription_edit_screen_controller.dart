import 'dart:math';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PrescriptionEditScreenController extends InheritedWidget {
  PrescriptionEditScreenController({
    required this.scaffoldKey,
    required TickerProvider tickerProvider,
    this.editPrescriptionId,
    this.editPrescription,
    Key? key,
    required Widget child,
  })  : tabController = TabController(
          initialIndex: editPrescription?.myType is MyTypeEnum
              ? max(MyTypeEnum.values.indexOf(editPrescription!.myType!), 0)
              : 0,
          length: MyTypeEnum.values.length - 1,
          vsync: tickerProvider,
        ),
        _configService = getIt<ConfigService>(),
        _prescriptionService = getIt<PrescriptionService>(),
        super(
          key: key,
          child: child,
        ) {
    if (isEdit) setEditedState();
  }

  final int? editPrescriptionId;
  final Prescription? editPrescription;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ConfigService _configService;
  final PrescriptionService _prescriptionService;
  final TabController tabController;

  final loadingState = BehaviorSubject<bool>.seeded(false);
  final screenState = BehaviorSubject<WidgetState<Prescription>?>();

  static PrescriptionEditScreenController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PrescriptionEditScreenController>();
  }

  @override
  bool updateShouldNotify(PrescriptionEditScreenController oldWidget) {
    return true;
  }

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
      scaffoldKey.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Wait when loading is done please.')));
    }
    return loadingState.value;
  }

  void setEditedState() {
    if (editPrescription != null) {
      screenState.add(WidgetState(editPrescription));
      return;
    }
    final id = editPrescriptionId;
    if (id != null) {
      screenState.add(WidgetState()..loading());
      _prescriptionService.fetchPrescriptionById(id).then(
        (prescription) {
          screenState.add(WidgetState(prescription));
          final type = prescription?.myType;
          final tabIndex = type != null ? MyTypeEnum.values.indexOf(type) : -1;
          if (tabIndex >= 0) tabController.animateTo(tabIndex - 1);
        },
      ).catchError(
        (e) {
          screenState.add(WidgetState()..error = e);
        },
      );
    }
  }
}

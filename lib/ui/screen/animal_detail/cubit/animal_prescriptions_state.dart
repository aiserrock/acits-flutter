import 'package:acits_core/acits_core.dart';
import 'package:acits_flutter/domain/prescription_model.dart';
import 'package:equatable/equatable.dart';

/// Состояние вкладки «Назначения» карточки животного (chopper-фича).
///
/// Держит состояние загрузки списка назначений ([prescriptions]) и флаг
/// переключателя «актуальные / прошлые» ([prescriptionActive]). Загрузка самого
/// животного живёт в модульном [AnimalDetailCubit] (богатая сущность), не здесь.
class AnimalPrescriptionsState extends Equatable {
  const AnimalPrescriptionsState({this.prescriptions = const DataState.loading(), this.prescriptionActive = true});

  /// Состояние загрузки списка назначений.
  final DataState<List<PrescriptionModel>?> prescriptions;

  /// Показывать ли актуальные назначения (иначе — прошлые).
  final bool prescriptionActive;

  AnimalPrescriptionsState copyWith({DataState<List<PrescriptionModel>?>? prescriptions, bool? prescriptionActive}) {
    return AnimalPrescriptionsState(
      prescriptions: prescriptions ?? this.prescriptions,
      prescriptionActive: prescriptionActive ?? this.prescriptionActive,
    );
  }

  @override
  List<Object?> get props => [prescriptions, prescriptionActive];
}

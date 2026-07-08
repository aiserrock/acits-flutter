import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:equatable/equatable.dart';

/// Состояние экрана карточки животного.
///
/// Держит состояние загрузки самого животного ([animal]), состояние загрузки
/// списка назначений ([prescriptions]) и флаг переключателя «актуальные /
/// прошлые» назначения ([prescriptionActive]). UI-контроллеры
/// (ScrollController, PageController) и локальные UI-флаги (вкладка,
/// прозрачность заголовка) остаются во [StatefulWidget] экрана.
class AnimalDetailState extends Equatable {
  const AnimalDetailState({
    this.animal = const DataState.loading(),
    this.prescriptions = const DataState.loading(),
    this.prescriptionActive = true,
  });

  /// Состояние загрузки животного.
  final DataState<AnimalRead> animal;

  /// Состояние загрузки списка назначений.
  final DataState<List<Prescription?>?> prescriptions;

  /// Показывать ли актуальные назначения (иначе — прошлые).
  final bool prescriptionActive;

  AnimalDetailState copyWith({
    DataState<AnimalRead>? animal,
    DataState<List<Prescription?>?>? prescriptions,
    bool? prescriptionActive,
  }) {
    return AnimalDetailState(
      animal: animal ?? this.animal,
      prescriptions: prescriptions ?? this.prescriptions,
      prescriptionActive: prescriptionActive ?? this.prescriptionActive,
    );
  }

  @override
  List<Object?> get props => [animal, prescriptions, prescriptionActive];
}

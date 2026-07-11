import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/ui/screen/animal_detail/cubit/animal_detail_state.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit экрана карточки животного.
///
/// Владеет состоянием загрузки животного и списка назначений, а также флагом
/// переключателя «актуальные / прошлые» назначения. Переключение флага само
/// перезагружает список назначений — без утекающей подписки на поток.
/// UI-контроллеры (ScrollController, PageController) и поток создания
/// комментариев остаются во [StatefulWidget] экрана.
class AnimalDetailCubit extends Cubit<AnimalDetailState> {
  AnimalDetailCubit({required this.id})
    : _animalService = getIt<AnimalService>(),
      _prescriptionService = getIt<PrescriptionService>(),
      super(const AnimalDetailState()) {
    loadAnimal();
    reloadPrescriptions();
  }

  final AnimalService _animalService;
  final PrescriptionService _prescriptionService;
  final int id;

  /// Текущее загруженное животное (для передачи в экран редактирования и т.п.).
  AnimalRead? get animalOrNull => state.animal.valueOrNull;

  /// Загрузить (или перезагрузить) карточку животного.
  Future<void> loadAnimal() async {
    Log.debug('AnimalDetailCubit.loadAnimal: id=$id');
    safeEmit(state.copyWith(animal: const DataState.loading()));
    try {
      final value = await _animalService.fetchAnimalDetail(id: id);
      Log.info('AnimalDetailCubit.loadAnimal ok: id=$id');
      safeEmit(state.copyWith(animal: DataState.content(value)));
    } catch (e, s) {
      Log.error('AnimalDetailCubit.loadAnimal failed: id=$id', e, s);
      safeEmit(state.copyWith(animal: DataState.error(e)));
    }
  }

  /// Переключить фильтр назначений (актуальные / прошлые) и перезагрузить их.
  void togglePrescriptionActive(bool isActive) {
    if (state.prescriptionActive == isActive) return;
    safeEmit(state.copyWith(prescriptionActive: isActive));
    reloadPrescriptions();
  }

  /// Загрузить список назначений с учётом текущего фильтра.
  Future<void> reloadPrescriptions() async {
    Log.debug('AnimalDetailCubit.reloadPrescriptions: id=$id active=${state.prescriptionActive}');
    safeEmit(state.copyWith(prescriptions: const DataState.loading()));
    try {
      final value = await _prescriptionService.fetchPrescriptionListByAnimal(
        id,
        isActual: state.prescriptionActive,
        isOld: !state.prescriptionActive,
      );
      Log.info('AnimalDetailCubit.reloadPrescriptions ok: count=${value?.results.length}');
      safeEmit(state.copyWith(prescriptions: DataState.content(value?.results)));
    } catch (e, s) {
      Log.error('AnimalDetailCubit.reloadPrescriptions failed: id=$id', e, s);
      safeEmit(state.copyWith(prescriptions: DataState.error(e)));
    }
  }
}

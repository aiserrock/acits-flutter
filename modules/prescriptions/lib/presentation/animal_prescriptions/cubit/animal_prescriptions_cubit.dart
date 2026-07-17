import 'package:acits_core/acits_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prescriptions/data/data.dart';
import 'package:prescriptions/presentation/animal_prescriptions/animal_prescriptions.dart';
import 'package:prescriptions/util/util.dart';

/// Cubit вкладки «Назначения» карточки животного.
///
/// Strangler-остаток: сама карточка животного мигрирована на модуль `animals`
/// (богатая сущность через репозиторий), а назначения — отдельная фича
/// ([PrescriptionService]). Этот cubit держит ТОЛЬКО загрузку списка назначений
/// и флаг «актуальные / прошлые». Рендерится внутри детального экрана
/// приложения (тот берёт cubit из барреля модуля).
class AnimalPrescriptionsCubit extends Cubit<AnimalPrescriptionsState> {
  AnimalPrescriptionsCubit(this._prescriptionService, {required this.animalId})
    : super(const AnimalPrescriptionsState()) {
    reloadPrescriptions();
  }

  final PrescriptionService _prescriptionService;
  final int animalId;

  /// Переключить фильтр назначений (актуальные / прошлые) и перезагрузить их.
  void togglePrescriptionActive(bool isActive) {
    if (state.prescriptionActive == isActive) return;
    safeEmit(state.copyWith(prescriptionActive: isActive));
    reloadPrescriptions();
  }

  /// Загрузить список назначений с учётом текущего фильтра.
  Future<void> reloadPrescriptions() async {
    // Фиксируем фильтр, под который запрашиваем. Если во время запроса
    // пользователь переключил тумблер (актуальные/прошлые), поздний ответ уже
    // не соответствует текущему выбору — не применяем его, иначе список не
    // совпадёт с положением переключателя.
    final requestedActive = state.prescriptionActive;
    Log.debug('AnimalPrescriptionsCubit.reload: id=$animalId active=$requestedActive');
    safeEmit(state.copyWith(prescriptions: const DataState.loading()));
    try {
      final value = await _prescriptionService.fetchPrescriptionListByAnimal(
        animalId,
        isActual: requestedActive,
        isOld: !requestedActive,
      );
      if (requestedActive != state.prescriptionActive) {
        Log.debug('AnimalPrescriptionsCubit.reload: stale filter, skip');
        return;
      }
      safeEmit(state.copyWith(prescriptions: DataState.content(value)));
    } catch (e, s) {
      if (requestedActive != state.prescriptionActive) return;
      Log.error('AnimalPrescriptionsCubit.reload failed: id=$animalId', e, s);
      safeEmit(state.copyWith(prescriptions: DataState.error(e)));
    }
  }
}

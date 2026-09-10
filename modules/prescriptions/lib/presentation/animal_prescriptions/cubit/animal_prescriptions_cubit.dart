import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/presentation/animal_prescriptions/animal_prescriptions.dart';
import 'package:prescriptions/util/util.dart';

/// Cubit вкладки «Назначения» карточки животного.
///
/// Сама карточка животного живёт в модуле `animals` (богатая сущность через
/// репозиторий), а назначения — отдельная фича ([PrescriptionRepository]). Этот
/// cubit держит ТОЛЬКО загрузку списка назначений и флаг «актуальные / прошлые».
/// Рендерится внутри детального экрана приложения (тот берёт cubit из барреля
/// модуля).
class AnimalPrescriptionsCubit extends Cubit<AnimalPrescriptionsState> {
  AnimalPrescriptionsCubit(this._repository, {required this.animalId}) : super(const AnimalPrescriptionsState()) {
    reloadPrescriptions();
  }

  final PrescriptionRepository _repository;
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
    final result = await _repository.listByAnimal(animalId, isActual: requestedActive, isOld: !requestedActive);
    if (requestedActive != state.prescriptionActive) {
      Log.debug('AnimalPrescriptionsCubit.reload: stale filter, skip');
      return;
    }
    result.fold((failure) {
      Log.error('AnimalPrescriptionsCubit.reload failed: id=$animalId', failure);
      safeEmit(state.copyWith(prescriptions: DataState.error(failure)));
    }, (value) => safeEmit(state.copyWith(prescriptions: DataState.content(value))));
  }
}

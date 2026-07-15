import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/util/logger/log.dart';

/// Cubit главного экрана (вкладка «Сегодня»).
///
/// Владеет состоянием загрузки [DataState] списка исполнений назначений на
/// сегодня и бизнес-логикой их загрузки. UI-контроллеры и флаги (например,
/// строка поиска) остаются во [StatefulWidget] экрана.
class MainCubit extends Cubit<DataState<PaginatedPrescriptionExecutionTodayList?>> {
  MainCubit() : _prescriptionService = getIt.get<PrescriptionService>(), super(const DataState.loading()) {
    loadExecutions();
  }

  final PrescriptionService _prescriptionService;

  /// Загружает список исполнений назначений на сегодня.
  ///
  /// Также используется как обработчик pull-to-refresh. При ошибке эмитит
  /// [DataState.error] (баг из аудита: старая реализация мутировала состояние
  /// без обновления UI — лоадер крутился вечно).
  Future<void> loadExecutions() async {
    Log.debug('MainCubit.loadExecutions');
    safeEmit(const DataState.loading());
    try {
      final value = await _prescriptionService.fetchTodayPrescriptionList();
      Log.info('MainCubit.loadExecutions ok: count=${value?.results?.length ?? 0}');
      safeEmit(DataState.content(value));
    } catch (e, s) {
      Log.error('MainCubit.loadExecutions failed', e, s);
      safeEmit(DataState.error(e));
    }
  }
}

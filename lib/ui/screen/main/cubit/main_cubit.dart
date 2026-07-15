import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/ui/screen/common/sort/sort_preset.dart';
import 'package:acits_flutter/ui/screen/main/cubit/main_state.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/util/logger/log.dart';

const _searchDebounce = Duration(milliseconds: 300);

/// Cubit главного экрана (вкладка «Сегодня»).
///
/// Владеет состоянием загрузки списка исполнений назначений на сегодня, а также
/// поиском (с debounce) и сортировкой. Поиск и сортировка комбинируются в одном
/// запросе (`search` + `ordering`). UI-контроллеры (TextEditingController)
/// остаются во [StatefulWidget] экрана.
class MainCubit extends Cubit<MainState> {
  MainCubit() : _prescriptionService = getIt.get<PrescriptionService>(), super(MainState()) {
    loadExecutions();
  }

  final PrescriptionService _prescriptionService;

  /// Таймер debounce для поля поиска.
  Timer? _searchDebounceTimer;

  /// Поколение запроса: инкрементится на каждую перезагрузку. Ответ запроса,
  /// стартовавшего до смены поиска/сортировки, приходит с устаревшим поколением
  /// и игнорируется — иначе поздний ответ мог перезаписать актуальную выдачу.
  int _requestGen = 0;

  /// Загружает список исполнений назначений на сегодня.
  ///
  /// Также используется как обработчик pull-to-refresh. Прокидывает текущий
  /// поиск и сортировку. При ошибке эмитит [DataState.error].
  Future<void> loadExecutions() async {
    Log.debug('MainCubit.loadExecutions search=${state.searchRequest} ordering=${state.activeSort.ordering}');
    _requestGen++;
    final gen = _requestGen;
    safeEmit(state.copyWith(data: const DataState.loading()));
    try {
      final value = await _prescriptionService.fetchTodayPrescriptionList(
        search: state.searchRequest.isEmpty ? null : state.searchRequest,
        ordering: state.activeSort.ordering,
      );
      if (gen != _requestGen) {
        Log.debug('MainCubit.loadExecutions: stale response gen=$gen cur=$_requestGen, skip');
        return;
      }
      Log.info('MainCubit.loadExecutions ok: count=${value?.results?.length ?? 0}');
      safeEmit(state.copyWith(data: DataState.content(value)));
    } catch (e, s) {
      if (gen != _requestGen) return;
      Log.error('MainCubit.loadExecutions failed', e, s);
      safeEmit(state.copyWith(data: DataState.error(e)));
    }
  }

  /// Переключить режим поиска. При выключении сбрасывает запрос и перезагружает.
  void toggleSearch() {
    final nextActive = !state.isSearchActive;
    if (!nextActive && state.searchRequest.isNotEmpty) {
      _searchDebounceTimer?.cancel();
      safeEmit(state.copyWith(isSearchActive: false, searchRequest: ''));
      loadExecutions();
      return;
    }
    safeEmit(state.copyWith(isSearchActive: nextActive));
  }

  /// Обработать ввод в поле поиска (debounce). Сортировка сохраняется.
  void onSearchChanged(String query) {
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounce, () {
      if (query == state.searchRequest) return;
      safeEmit(state.copyWith(searchRequest: query));
      loadExecutions();
    });
  }

  /// Сменить пресет сортировки. Перезагружает с новым `ordering`, сохраняя
  /// поиск. Отменяет висящий debounce поиска, чтобы он не выстрелил лишним
  /// запросом после смены сортировки.
  void onSortChanged(SortPreset preset) {
    if (preset == state.activeSort) return;
    _searchDebounceTimer?.cancel();
    safeEmit(state.copyWith(activeSort: preset));
    loadExecutions();
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }
}

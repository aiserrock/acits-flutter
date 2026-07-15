import 'package:equatable/equatable.dart';

import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/ui/screen/common/sort/sort_preset.dart';
import 'package:acits_flutter/util/data_state.dart';

/// Состояние главного экрана (вкладка «Сегодня»).
///
/// Держит состояние загрузки списка исполнений на сегодня ([data]), флаг
/// активного поиска ([isSearchActive]), поисковый запрос ([searchRequest]) и
/// активный пресет сортировки ([activeSort]). Поиск и сортировка комбинируются
/// в одном запросе. UI-контроллеры остаются во [StatefulWidget] экрана.
class MainState extends Equatable {
  MainState({
    this.data = const DataState.loading(),
    this.isSearchActive = false,
    this.searchRequest = '',
    SortPreset? activeSort,
  }) : activeSort = activeSort ?? kTodaySortPresets.first;

  /// Состояние загрузки списка исполнений на сегодня.
  final DataState<PaginatedPrescriptionExecutionTodayList?> data;

  /// Активен ли режим поиска в шапке экрана.
  final bool isSearchActive;

  /// Текущий поисковый запрос (пустая строка — поиск не задан).
  final String searchRequest;

  /// Активный пресет сортировки (по умолчанию — «По времени»).
  final SortPreset activeSort;

  MainState copyWith({
    DataState<PaginatedPrescriptionExecutionTodayList?>? data,
    bool? isSearchActive,
    String? searchRequest,
    SortPreset? activeSort,
  }) {
    return MainState(
      data: data ?? this.data,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      searchRequest: searchRequest ?? this.searchRequest,
      activeSort: activeSort ?? this.activeSort,
    );
  }

  @override
  List<Object?> get props => [data, isSearchActive, searchRequest, activeSort];
}

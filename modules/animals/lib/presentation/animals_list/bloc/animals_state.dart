import 'package:base/base.dart';
import 'package:ui_kit/acits_ui_kit.dart';
import 'package:equatable/equatable.dart';

import 'package:animals/domain/domain.dart';
import 'package:animals/presentation/animals_list/animals_list.dart';

/// Состояние экрана списка животных.
///
/// Держит основное состояние загрузки списка ([data]), состояние догрузки
/// следующей страницы ([page]), флаг активного поиска ([isSearchActive]),
/// текущий поисковый запрос ([searchRequest]) и активный пресет сортировки
/// ([activeSort]). Поиск и сортировка комбинируются в одном запросе.
/// UI-контроллеры (ScrollController) остаются во [StatefulWidget] экрана.
class AnimalsState extends Equatable {
  AnimalsState({
    this.data = const DataState.loading(),
    this.page = const DataState.content(0),
    this.isSearchActive = false,
    this.searchRequest = '',
    SortPreset? activeSort,
  }) : activeSort = activeSort ?? kAnimalSortPresets.first;

  /// Состояние основного списка животных (доменные сущности, не DTO).
  final DataState<List<AnimalListItem>> data;

  /// Состояние догрузки очередной страницы (индикатор внизу списка).
  final DataState<int> page;

  /// Активен ли режим поиска в шапке экрана.
  final bool isSearchActive;

  /// Текущий поисковый запрос (пустая строка — поиск не задан).
  final String searchRequest;

  /// Активный пресет сортировки (по умолчанию — «Сначала новые»).
  final SortPreset activeSort;

  AnimalsState copyWith({
    DataState<List<AnimalListItem>>? data,
    DataState<int>? page,
    bool? isSearchActive,
    String? searchRequest,
    SortPreset? activeSort,
  }) {
    return AnimalsState(
      data: data ?? this.data,
      page: page ?? this.page,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      searchRequest: searchRequest ?? this.searchRequest,
      activeSort: activeSort ?? this.activeSort,
    );
  }

  @override
  List<Object?> get props => [data, page, isSearchActive, searchRequest, activeSort];
}

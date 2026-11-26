import 'package:util/util.dart';
import 'package:equatable/equatable.dart';

import 'package:prescriptions/domain/domain.dart';

/// Состояние экрана «Медикаменты».
///
/// Держит основной список ([data]), состояние догрузки следующей страницы
/// ([page], значение — сколько препаратов уже загружено), поисковый запрос
/// ([searchRequest]) и флаг активного поиска в шапке ([isSearchActive]).
class DrugsState extends Equatable {
  const DrugsState({
    this.data = const DataState.loading(),
    this.page = const DataState.content(0),
    this.isSearchActive = false,
    this.searchRequest = '',
  });

  /// Основной список препаратов каталога.
  final DataState<List<Drug>> data;

  /// Состояние догрузки очередной страницы (индикатор внизу списка).
  final DataState<int> page;

  /// Активен ли режим поиска в шапке экрана.
  final bool isSearchActive;

  /// Текущий поисковый запрос (пустая строка — поиск не задан).
  final String searchRequest;

  DrugsState copyWith({
    DataState<List<Drug>>? data,
    DataState<int>? page,
    bool? isSearchActive,
    String? searchRequest,
  }) {
    return DrugsState(
      data: data ?? this.data,
      page: page ?? this.page,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      searchRequest: searchRequest ?? this.searchRequest,
    );
  }

  @override
  List<Object?> get props => [data, page, isSearchActive, searchRequest];
}

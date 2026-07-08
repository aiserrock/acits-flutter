import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:equatable/equatable.dart';

/// Состояние экрана поиска вида животного.
///
/// [data] — состояние загрузки основного списка видов ([DataState]).
/// [offset] — текущее смещение пагинации. [isPaging] — идёт ли догрузка
/// следующей страницы. [pagingError] — ошибка последней догрузки (или null).
class SearchSpecState extends Equatable {
  const SearchSpecState({
    this.data = const DataState.loading(),
    this.offset = 0,
    this.isPaging = false,
    this.pagingError,
  });

  /// Состояние основного списка видов.
  final DataState<List<Species>> data;

  /// Текущее смещение пагинации (кол-во уже загруженных элементов).
  final int offset;

  /// Идёт ли догрузка следующей страницы.
  final bool isPaging;

  /// Ошибка последней догрузки страницы (null — ошибки нет).
  final Object? pagingError;

  SearchSpecState copyWith({
    DataState<List<Species>>? data,
    int? offset,
    bool? isPaging,
    Object? Function()? pagingError,
  }) {
    return SearchSpecState(
      data: data ?? this.data,
      offset: offset ?? this.offset,
      isPaging: isPaging ?? this.isPaging,
      pagingError: pagingError != null ? pagingError() : this.pagingError,
    );
  }

  @override
  List<Object?> get props => [data, offset, isPaging, pagingError];
}

part of 'search_bloc.dart';

enum SearchStatus { loading, success, failure }

/// Сентинел для copyWith: отличает «не передано» (оставить как есть) от явного
/// сброса nullable-поля в null. Без него `error ?? this.error` не давал очистить
/// ошибку после успешного запроса.
const Object _unset = Object();

class SearchState<T> extends Equatable {
  const SearchState({
    required this.items,
    required this.status,
    required this.isReachedMax,
    required this.searchRequest,
    this.error,
  });

  // ignore: prefer_const_constructors
  factory SearchState.initial() => SearchState(
    // ignore: prefer_const_literals_to_create_immutables
    items: <T>[],
    status: SearchStatus.success,
    isReachedMax: false,
    searchRequest: '',
  );

  final Object? error;
  final List<T> items;
  final SearchStatus status;
  final bool isReachedMax;
  final String searchRequest;

  SearchState<T> copyWith({
    Object? error = _unset,
    List<T>? items,
    SearchStatus? status,
    bool? isReachedMax,
    String? searchRequest,
  }) {
    return SearchState(
      // error по умолчанию = _unset → берём текущее; передача любого другого
      // значения (включая null) заменяет его. Позволяет очистить ошибку.
      error: identical(error, _unset) ? this.error : error,
      items: items ?? this.items,
      status: status ?? this.status,
      isReachedMax: isReachedMax ?? this.isReachedMax,
      searchRequest: searchRequest ?? this.searchRequest,
    );
  }

  @override
  List<Object?> get props => [items, status, isReachedMax, searchRequest, error];

  bool get isInitFailure => status == SearchStatus.failure && items.isEmpty;
  bool get isInitLoading => status == SearchStatus.loading && items.isEmpty;
  bool get isLoading => status == SearchStatus.loading;
  bool get hasError => status == SearchStatus.failure;
}

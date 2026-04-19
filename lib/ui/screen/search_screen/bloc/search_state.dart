part of 'search_bloc.dart';

enum SearchStatus { loading, success, failure }

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
    Object? error,
    List<T>? items,
    SearchStatus? status,
    bool? isReachedMax,
    String? searchRequest,
  }) {
    return SearchState(
      error: error ?? this.error,
      items: items ?? this.items,
      status: status ?? this.status,
      isReachedMax: isReachedMax ?? this.isReachedMax,
      searchRequest: searchRequest ?? this.searchRequest,
    );
  }

  @override
  List<Object> get props => [items, status, isReachedMax, searchRequest];

  bool get isInitFailure => status == SearchStatus.failure && items.isEmpty;
  bool get isInitLoading => status == SearchStatus.loading && items.isEmpty;
  bool get isLoading => status == SearchStatus.loading;
  bool get hasError => status == SearchStatus.failure;
}

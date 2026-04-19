import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:equatable/equatable.dart';

import 'package:acits_flutter/ui/screen/search_screen/search.dart';

part 'search_event.dart';
part 'search_state.dart';

const _defaultPageLimit = 25;
const _throttleDuration = Duration(milliseconds: 300);

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class SearchBloc<T> extends Bloc<SearchEvent, SearchState<T>> {
  final PagingFetchAdapter adapter;
  final int pageLimit;

  SearchBloc({
    required this.adapter,
    this.pageLimit = _defaultPageLimit,
  }) : super(SearchState.initial()) {
    on<FetchNextSearchEvent>(_onFetchNext, transformer: _throttleDroppable(_throttleDuration));
    on<ResetFetchSearchEvent>(_onResetFetch, transformer: _throttleDroppable(_throttleDuration));
    on<ChangeSearchRequestSearchEvent>(_onChangeSearch,
        transformer: _throttleDroppable(_throttleDuration));
  }

  Future<void> _onFetchNext(
    FetchNextSearchEvent event,
    Emitter<SearchState<T>> emitter,
  ) async {
    if (state.status == SearchStatus.loading || state.isReachedMax) return;

    emitter(state.copyWith(status: SearchStatus.loading));

    await adapter
        .fetch(
      limit: pageLimit,
      offset: state.items.length,
      search: state.searchRequest,
    )
        .then(
      (value) {
        emitter(
          state.copyWith(
            status: SearchStatus.success,
            items: List.of(state.items)..addAll(value as List<T>),
            isReachedMax: value.length < pageLimit,
          ),
        );
      },
    ).catchError(
      (error) {
        emitter(
          state.copyWith(
            status: SearchStatus.failure,
            error: error,
          ),
        );
      },
    );
  }

  Future<void> _onResetFetch(
    ResetFetchSearchEvent event,
    Emitter<SearchState<T>> emitter,
  ) async {
    if (state.status == SearchStatus.loading) return;

    emitter(state.copyWith(status: SearchStatus.loading));

    await adapter
        .fetch(
      limit: pageLimit,
      offset: 0,
      search: state.searchRequest,
    )
        .then(
      (value) {
        emitter(
          state.copyWith(
            status: SearchStatus.success,
            items: value as List<T>,
            isReachedMax: value.length < pageLimit,
          ),
        );
      },
    ).catchError(
      (error) {
        emitter(
          state.copyWith(
            status: SearchStatus.failure,
            error: error,
          ),
        );
      },
    );
  }

  Future<void> _onChangeSearch(
    ChangeSearchRequestSearchEvent event,
    Emitter<SearchState<T>> emitter,
  ) async {
    if (state.status == SearchStatus.loading) return;

    emitter(state.copyWith(status: SearchStatus.loading));

    await adapter
        .fetch(
      limit: pageLimit,
      offset: 0,
      search: event.searchRequest,
    )
        .then(
      (value) {
        emitter(
          state.copyWith(
            status: SearchStatus.success,
            items: value as List<T>,
            searchRequest: event.searchRequest,
            isReachedMax: value.length < pageLimit,
          ),
        );
      },
    ).catchError(
      (error) {
        emitter(
          state.copyWith(
            status: SearchStatus.failure,
            error: error,
            searchRequest: event.searchRequest,
          ),
        );
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:equatable/equatable.dart';

import 'package:acits_flutter/ui/screen/search_screen/search.dart';
import 'package:acits_flutter/util/logger/log.dart';

part 'search_event.dart';
part 'search_state.dart';

const _defaultPageLimit = 25;
const _throttleDuration = Duration(milliseconds: 300);

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

/// Для ввода поиска: debounce (ждём паузу в наборе) + restartable (отменяем
/// предыдущий запрос и запускаем по последней строке). Раньше здесь стоял
/// throttle+droppable, из-за чего последний введённый запрос мог не выполниться
/// вовсе — droppable ронял событие, пока шёл предыдущий fetch.
EventTransformer<E> _debounceRestartable<E>(Duration duration) {
  return (events, mapper) {
    return restartable<E>().call(events.debounce(duration), mapper);
  };
}

class SearchBloc<T> extends Bloc<SearchEvent, SearchState<T>> {
  final PagingFetchAdapter adapter;
  final int pageLimit;

  SearchBloc({required this.adapter, this.pageLimit = _defaultPageLimit}) : super(SearchState.initial()) {
    on<FetchNextSearchEvent>(_onFetchNext, transformer: _throttleDroppable(_throttleDuration));
    on<ResetFetchSearchEvent>(_onResetFetch, transformer: _throttleDroppable(_throttleDuration));
    on<ChangeSearchRequestSearchEvent>(_onChangeSearch, transformer: _debounceRestartable(_throttleDuration));
  }

  Future<void> _onFetchNext(FetchNextSearchEvent event, Emitter<SearchState<T>> emitter) async {
    if (state.status == SearchStatus.loading || state.isReachedMax) return;

    Log.debug('SearchBloc.fetchNext offset=${state.items.length}');
    emitter(state.copyWith(status: SearchStatus.loading));

    await adapter
        .fetch(limit: pageLimit, offset: state.items.length, search: state.searchRequest)
        .then((value) {
          Log.info('SearchBloc.fetchNext ok: +${value.length} items');
          emitter(
            state.copyWith(
              status: SearchStatus.success,
              items: List.of(state.items)..addAll(value as List<T>),
              isReachedMax: value.length < pageLimit,
              error: null,
            ),
          );
        })
        .catchError((Object error, StackTrace s) {
          Log.error('SearchBloc.fetchNext failed', error, s);
          emitter(state.copyWith(status: SearchStatus.failure, error: error));
        });
  }

  Future<void> _onResetFetch(ResetFetchSearchEvent event, Emitter<SearchState<T>> emitter) async {
    if (state.status == SearchStatus.loading) return;

    Log.debug('SearchBloc.resetFetch search=${state.searchRequest}');
    emitter(state.copyWith(status: SearchStatus.loading));

    await adapter
        .fetch(limit: pageLimit, offset: 0, search: state.searchRequest)
        .then((value) {
          Log.info('SearchBloc.resetFetch ok: ${value.length} items');
          emitter(
            state.copyWith(
              status: SearchStatus.success,
              items: value as List<T>,
              isReachedMax: value.length < pageLimit,
              error: null,
            ),
          );
        })
        .catchError((Object error, StackTrace s) {
          Log.error('SearchBloc.resetFetch failed', error, s);
          emitter(state.copyWith(status: SearchStatus.failure, error: error));
        });
  }

  Future<void> _onChangeSearch(ChangeSearchRequestSearchEvent event, Emitter<SearchState<T>> emitter) async {
    // Без раннего return по loading: transformer restartable отменяет прошлый
    // обработчик, поэтому актуален всегда последний ввод. Прошлая проверка
    // `status == loading` глушила новый запрос и оставляла устаревшие результаты.
    Log.debug('SearchBloc.changeSearch search=${event.searchRequest}');
    emitter(state.copyWith(status: SearchStatus.loading, searchRequest: event.searchRequest));

    await adapter
        .fetch(limit: pageLimit, offset: 0, search: event.searchRequest)
        .then((value) {
          Log.info('SearchBloc.changeSearch ok: ${value.length} items');
          emitter(
            state.copyWith(
              status: SearchStatus.success,
              items: value as List<T>,
              searchRequest: event.searchRequest,
              isReachedMax: value.length < pageLimit,
              error: null,
            ),
          );
        })
        .catchError((Object error, StackTrace s) {
          Log.error('SearchBloc.changeSearch failed', error, s);
          emitter(state.copyWith(status: SearchStatus.failure, error: error, searchRequest: event.searchRequest));
        });
  }
}

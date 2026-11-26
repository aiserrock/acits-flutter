import 'dart:async';

import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prescriptions/domain/domain.dart';
import 'package:prescriptions/presentation/drugs/cubit/drugs_state.dart';
import 'package:prescriptions/util/util.dart';

/// Размер страницы каталога препаратов.
const drugsPageSize = 25;

const _defaultSearchDebounce = Duration(milliseconds: 400);

/// Cubit экрана «Медикаменты» (только чтение).
///
/// Владеет списком препаратов ([DataState]), пагинацией по offset, поиском с
/// debounce и защитой от устаревших ответов. Список загружается сразу при
/// создании.
class DrugsCubit extends Cubit<DrugsState> {
  DrugsCubit(this._repository, {Duration searchDebounce = _defaultSearchDebounce})
    : _searchDebounce = searchDebounce,
      super(const DrugsState()) {
    reload();
  }

  final PrescriptionRepository _repository;
  final Duration _searchDebounce;

  /// Таймер debounce поля поиска: перезапускается на каждый символ.
  Timer? _searchDebounceTimer;

  int _offset = 0;

  /// Последняя страница вернула меньше [drugsPageSize] — догружать нечего.
  bool _reachedEnd = false;

  /// Поколение запроса: инкрементится при каждом reset (старт, поиск,
  /// pull-to-refresh). Ответ запроса из прошлого поколения игнорируется, иначе
  /// поздний ответ склеил бы старую выдачу с новой и сбил offset.
  int _requestGen = 0;

  /// Переключить режим поиска. При выключении сбрасывает запрос и перезагружает
  /// список, чтобы не остаться на отфильтрованной выдаче.
  void toggleSearch() {
    final nextActive = !state.isSearchActive;
    if (!nextActive && state.searchRequest.isNotEmpty) {
      _searchDebounceTimer?.cancel();
      safeEmit(state.copyWith(isSearchActive: false, searchRequest: ''));
      reload();
      return;
    }
    _searchDebounceTimer?.cancel();
    safeEmit(state.copyWith(isSearchActive: nextActive));
  }

  /// Обработать ввод в поле поиска: запрос уходит после паузы в наборе.
  void onSearchChanged(String query) {
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounce, () {
      if (query == state.searchRequest) return;
      safeEmit(state.copyWith(searchRequest: query));
      reload();
    });
  }

  /// Загрузить первую страницу заново (старт, поиск, pull-to-refresh, retry).
  Future<void> reload() {
    _offset = 0;
    _reachedEnd = false;
    _requestGen++;
    safeEmit(state.copyWith(data: const DataState.loading(), page: const DataState.content(0)));
    return _fetch();
  }

  /// Догрузить следующую страницу (infinite scroll).
  ///
  /// Не стартует, пока идёт догрузка или перезагрузка основного списка, и после
  /// достижения конца списка. После ошибки догрузки повторный вызов повторяет
  /// запрос.
  void loadNextPage() {
    if (state.page.isLoading || state.data.isLoading || _reachedEnd) return;
    if (state.data.valueOrNull == null) return;
    safeEmit(state.copyWith(page: const DataState.loading()));
    _fetch();
  }

  Future<void> _fetch() async {
    final gen = _requestGen;
    final isFirstPage = _offset == 0;
    final query = state.searchRequest;
    final result = await _repository.listDrugs(
      searchRequest: query.isEmpty ? null : query,
      limit: drugsPageSize,
      offset: _offset,
    );
    if (gen != _requestGen) {
      Log.debug('DrugsCubit: stale response gen=$gen cur=$_requestGen, skip');
      return;
    }
    result.fold(
      (failure) {
        Log.error('DrugsCubit: load failed offset=$_offset', failure);
        safeEmit(
          isFirstPage ? state.copyWith(data: DataState.error(failure)) : state.copyWith(page: DataState.error(failure)),
        );
      },
      (fetched) {
        final all = <Drug>[...?state.data.valueOrNull, ...fetched];
        _offset += fetched.length;
        if (fetched.length < drugsPageSize) _reachedEnd = true;
        safeEmit(state.copyWith(data: DataState.content(all), page: DataState.content(_offset)));
      },
    );
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }
}

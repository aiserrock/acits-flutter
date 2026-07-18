import 'dart:async';

import 'package:base/base.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animals/domain/domain.dart';
import 'package:animals/presentation/animals_list/animals_list.dart';

const _animalPageLength = 25;
const _searchDebounce = Duration(milliseconds: 300);

/// Cubit экрана списка животных.
///
/// Владеет состоянием списка [DataState], пагинацией (offset) и логикой
/// удаления с оптимистичным откатом. Данные — доменные [AnimalListItem] из
/// [AnimalRepository] (Result, без DTO). ScrollController остаётся во
/// [StatefulWidget] экрана.
class AnimalsCubit extends Cubit<AnimalsState> {
  AnimalsCubit(this._repository, this._shelterProvider) : super(AnimalsState()) {
    loadAnimalList(needResetOffset: true);
  }

  final AnimalRepository _repository;
  final CurrentShelterProvider _shelterProvider;

  /// Таймер debounce для ввода в поле поиска: перезапускается на каждый символ,
  /// запрос уходит только после паузы в наборе.
  Timer? _searchDebounceTimer;

  int _currentListOffset = 0;

  /// Достигнут ли конец списка (последняя страница вернула меньше [_animalPageLength]).
  bool _reachedEnd = false;

  /// Поколение запроса. Инкрементится при каждом reset (pull-to-refresh):
  /// ответ догрузки страницы, стартовавшей до reset, приходит с устаревшим
  /// поколением и игнорируется — иначе поздний ответ склеивал старый список с
  /// новым (дубликаты) и сбивал offset.
  int _requestGen = 0;

  void _safeEmit(AnimalsState state) {
    if (isClosed) return;
    emit(state);
  }

  /// Переключить режим поиска в шапке экрана. При выключении сбрасывает
  /// поисковый запрос и перезагружает список (чтобы не остаться на
  /// отфильтрованной выдаче).
  void toggleSearch() {
    final nextActive = !state.isSearchActive;
    if (!nextActive && state.searchRequest.isNotEmpty) {
      _searchDebounceTimer?.cancel();
      _safeEmit(state.copyWith(isSearchActive: false, searchRequest: ''));
      loadAnimalList(needResetOffset: true);
      return;
    }
    _safeEmit(state.copyWith(isSearchActive: nextActive));
  }

  /// Обработать ввод в поле поиска (debounce). Запрос уходит после паузы в
  /// наборе; сортировка сохраняется и комбинируется с поиском.
  void onSearchChanged(String query) {
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounce, () {
      if (query == state.searchRequest) return;
      _safeEmit(state.copyWith(searchRequest: query));
      loadAnimalList(needResetOffset: true);
    });
  }

  /// Сменить пресет сортировки. Перезагружает список с новым `ordering`,
  /// сохраняя текущий поисковый запрос. Отменяет висящий debounce поиска, чтобы
  /// он не выстрелил лишним запросом после смены сортировки.
  void onSortChanged(SortPreset preset) {
    if (preset == state.activeSort) return;
    _searchDebounceTimer?.cancel();
    _safeEmit(state.copyWith(activeSort: preset));
    loadAnimalList(needResetOffset: true);
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }

  /// Идёт ли сейчас догрузка следующей страницы.
  bool get _isPageLoading => state.page.isLoading;

  /// Запросить догрузку следующей страницы (для infinite scroll).
  ///
  /// Guard на `data.isLoading`: при reset (смена поиска/сортировки/refresh) в
  /// loading переводится основной список, но `page` остаётся content — без этой
  /// проверки одновременный доскролл мог запустить вторую загрузку в том же
  /// поколении и продублировать первую страницу.
  void loadNextPage() {
    if (_isPageLoading || _reachedEnd || state.data.isLoading) return;
    _safeEmit(state.copyWith(page: const DataState.loading()));
    loadAnimalList();
  }

  /// Загрузить список животных.
  ///
  /// При [needResetOffset] сбрасывает offset и показывает основной лоадер,
  /// иначе догружает следующую страницу к текущему списку.
  Future<void> loadAnimalList({bool needResetOffset = false}) async {
    if (needResetOffset) {
      _currentListOffset = 0;
      _reachedEnd = false;
      _requestGen++;
      _safeEmit(state.copyWith(data: const DataState.loading()));
    }
    final gen = _requestGen;
    final result = await _repository.list(
      shelterId: _shelterProvider.shelterId,
      offset: _currentListOffset,
      limit: _animalPageLength,
      search: state.searchRequest.isEmpty ? null : state.searchRequest,
      ordering: state.activeSort.ordering,
    );
    // Пока шёл запрос, случился reset (сменилось поколение) — этот ответ
    // устарел, не применяем.
    if (gen != _requestGen) return;
    result.fold(
      (failure) {
        if (needResetOffset) {
          _safeEmit(state.copyWith(data: DataState.error(failure)));
        } else {
          _safeEmit(state.copyWith(page: DataState.error(failure)));
        }
      },
      (fetched) {
        final newList = <AnimalListItem>[...?state.data.valueOrNull, ...fetched];
        _currentListOffset += fetched.length;
        if (fetched.length < _animalPageLength) _reachedEnd = true;
        _safeEmit(state.copyWith(data: DataState.content(newList), page: DataState.content(_currentListOffset)));
      },
    );
  }

  /// Удалить животное с оптимистичным откатом.
  ///
  /// Возвращает `true`, если удаление прошло успешно; `false` — если запрос
  /// упал и список был восстановлен (виджет показывает snackbar).
  Future<bool> deleteAnimal(AnimalListItem item) async {
    final current = state.data.valueOrNull;
    if (current == null) return false;
    final index = current.indexOf(item);
    final optimistic = List<AnimalListItem>.from(current)..remove(item);
    _safeEmit(state.copyWith(data: DataState.content(optimistic)));

    final result = await _repository.delete(item.id, shelterId: _shelterProvider.shelterId);
    if (result.isOk) return true;

    final restored = List<AnimalListItem>.from(state.data.valueOrNull ?? const [])..insert(index < 0 ? 0 : index, item);
    _safeEmit(state.copyWith(data: DataState.content(restored)));
    return false;
  }
}

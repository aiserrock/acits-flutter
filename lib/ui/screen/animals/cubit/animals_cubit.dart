import 'dart:async';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/animals/cubit/animals_state.dart';
import 'package:acits_flutter/ui/screen/common/sort/sort_preset.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

const _animalPageLength = 25;
const _searchDebounce = Duration(milliseconds: 300);

/// Cubit экрана списка животных.
///
/// Владеет состоянием списка [DataState], пагинацией (offset) и логикой
/// удаления с оптимистичным откатом. ScrollController остаётся во
/// [StatefulWidget] экрана.
class AnimalsCubit extends Cubit<AnimalsState> {
  AnimalsCubit() : _animalService = getIt<AnimalService>(), super(AnimalsState()) {
    loadAnimalList(needResetOffset: true);
  }

  final AnimalService _animalService;

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

  /// Переключить режим поиска в шапке экрана. При выключении сбрасывает
  /// поисковый запрос и перезагружает список (чтобы не остаться на
  /// отфильтрованной выдаче).
  void toggleSearch() {
    final nextActive = !state.isSearchActive;
    if (!nextActive && state.searchRequest.isNotEmpty) {
      _searchDebounceTimer?.cancel();
      safeEmit(state.copyWith(isSearchActive: false, searchRequest: ''));
      loadAnimalList(needResetOffset: true);
      return;
    }
    safeEmit(state.copyWith(isSearchActive: nextActive));
  }

  /// Обработать ввод в поле поиска (debounce). Запрос уходит после паузы в
  /// наборе; сортировка сохраняется и комбинируется с поиском.
  void onSearchChanged(String query) {
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounce, () {
      if (query == state.searchRequest) return;
      safeEmit(state.copyWith(searchRequest: query));
      loadAnimalList(needResetOffset: true);
    });
  }

  /// Сменить пресет сортировки. Перезагружает список с новым `ordering`,
  /// сохраняя текущий поисковый запрос. Отменяет висящий debounce поиска, чтобы
  /// он не выстрелил лишним запросом после смены сортировки.
  void onSortChanged(SortPreset preset) {
    if (preset == state.activeSort) return;
    _searchDebounceTimer?.cancel();
    safeEmit(state.copyWith(activeSort: preset));
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
    safeEmit(state.copyWith(page: const DataState.loading()));
    loadAnimalList();
  }

  /// Загрузить список животных.
  ///
  /// При [needResetOffset] сбрасывает offset и показывает основной лоадер,
  /// иначе догружает следующую страницу к текущему списку.
  Future<void> loadAnimalList({bool needResetOffset = false}) async {
    Log.debug('AnimalsCubit.loadAnimalList: reset=$needResetOffset offset=$_currentListOffset');
    if (needResetOffset) {
      _currentListOffset = 0;
      _reachedEnd = false;
      _requestGen++;
      safeEmit(state.copyWith(data: const DataState.loading()));
    }
    final gen = _requestGen;
    try {
      final value = await _animalService.fetchAnimalList(
        offset: _currentListOffset,
        limit: _animalPageLength,
        searchRequest: state.searchRequest.isEmpty ? null : state.searchRequest,
        ordering: state.activeSort.ordering,
      );
      // Пока шёл запрос, случился reset (сменилось поколение) — этот ответ
      // устарел, не применяем.
      if (gen != _requestGen) {
        Log.debug('AnimalsCubit.loadAnimalList: stale response gen=$gen cur=$_requestGen, skip');
        return;
      }
      final fetched = value?.results ?? const [];
      final newList = <AnimalRead>[...?state.data.valueOrNull, ...fetched];
      _currentListOffset += fetched.length;
      if (fetched.length < _animalPageLength) _reachedEnd = true;
      Log.info('AnimalsCubit.loadAnimalList ok: fetched=${fetched.length} total=${newList.length}');
      safeEmit(
        state.copyWith(
          data: DataState.content(newList),
          page: DataState.content(_currentListOffset),
        ),
      );
    } catch (e, s) {
      if (gen != _requestGen) return;
      Log.error('AnimalsCubit.loadAnimalList failed: reset=$needResetOffset', e, s);
      if (needResetOffset) {
        safeEmit(state.copyWith(data: DataState.error(e)));
      } else {
        safeEmit(state.copyWith(page: DataState.error(e)));
      }
    }
  }

  /// Удалить животное с оптимистичным откатом.
  ///
  /// Возвращает `true`, если удаление прошло успешно; `false` — если запрос
  /// упал и список был восстановлен (виджет показывает snackbar).
  Future<bool> deleteAnimal(AnimalRead item) async {
    Log.debug('AnimalsCubit.deleteAnimal: id=${item.id}');
    final current = state.data.valueOrNull;
    if (current == null) return false;
    final index = current.indexOf(item);
    final optimistic = List<AnimalRead>.from(current)..remove(item);
    safeEmit(state.copyWith(data: DataState.content(optimistic)));
    try {
      await _animalService.deleteAnimal(item.id.toString());
      Log.info('AnimalsCubit.deleteAnimal ok: id=${item.id}');
      return true;
    } catch (e, s) {
      Log.error('AnimalsCubit.deleteAnimal failed, rolled back: id=${item.id}', e, s);
      final restored = List<AnimalRead>.from(state.data.valueOrNull ?? const [])
        ..insert(index < 0 ? 0 : index, item);
      safeEmit(state.copyWith(data: DataState.content(restored)));
      return false;
    }
  }
}

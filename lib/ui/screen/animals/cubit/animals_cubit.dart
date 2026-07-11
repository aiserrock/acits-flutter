import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/animals/cubit/animals_state.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

const _animalPageLength = 25;

/// Cubit экрана списка животных.
///
/// Владеет состоянием списка [DataState], пагинацией (offset) и логикой
/// удаления с оптимистичным откатом. ScrollController остаётся во
/// [StatefulWidget] экрана.
class AnimalsCubit extends Cubit<AnimalsState> {
  AnimalsCubit() : _animalService = getIt<AnimalService>(), super(const AnimalsState()) {
    loadAnimalList(needResetOffset: true);
  }

  final AnimalService _animalService;

  int _currentListOffset = 0;

  /// Достигнут ли конец списка (последняя страница вернула меньше [_animalPageLength]).
  bool _reachedEnd = false;

  /// Переключить режим поиска в шапке экрана.
  void toggleSearch() {
    safeEmit(state.copyWith(isSearchActive: !state.isSearchActive));
  }

  /// Идёт ли сейчас догрузка следующей страницы.
  bool get _isPageLoading => state.page.isLoading;

  /// Запросить догрузку следующей страницы (для infinite scroll).
  void loadNextPage() {
    if (_isPageLoading || _reachedEnd) return;
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
      safeEmit(state.copyWith(data: const DataState.loading()));
    }
    try {
      final value = await _animalService.fetchAnimalList(
        offset: _currentListOffset,
        limit: _animalPageLength,
      );
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

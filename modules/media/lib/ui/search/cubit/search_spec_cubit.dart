import 'dart:async';

import 'package:acits_core/acits_core.dart';
import 'package:animals/animals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/bloc_ext.dart';
import '../../../util/log.dart';
import 'search_spec_state.dart';

const _searchBouncePeriod = Duration(milliseconds: 1000);

/// Cubit экрана поиска вида животного.
///
/// Владеет состоянием списка видов ([DataState]), пагинацией и бизнес-логикой
/// поиска с дебаунсом. UI-контроллеры ([ScrollController], [TextEditingController])
/// остаются во [StatefulWidget] экрана. Данные — доменные [AnimalSpecies] через
/// модульный [AnimalRepository].
class SearchSpecCubit extends Cubit<SearchSpecState> {
  SearchSpecCubit(this._repository, this._shelterProvider, {this.parentSearch}) : super(const SearchSpecState()) {
    loadData(searchRequest: null, resetOffset: true);
  }

  final AnimalRepository _repository;
  final CurrentShelterProvider _shelterProvider;

  /// Родительский вид, внутри которого выполняется поиск (или null — верхний уровень).
  final AnimalSpecies? parentSearch;

  Timer? _bounceTimer;

  /// Обработать изменение строки поиска с дебаунсом.
  ///
  /// Пустой запрос загружается сразу, непустой — после паузы [_searchBouncePeriod].
  void onSearchChanged(String query) {
    _bounceTimer?.cancel();
    if (query.isEmpty) {
      loadData(searchRequest: null, resetOffset: true);
      return;
    }
    _bounceTimer = Timer(_searchBouncePeriod, () => loadData(searchRequest: query, resetOffset: true));
  }

  /// Догрузить следующую страницу, если сейчас нет активной загрузки.
  void loadMore(String query) {
    if (state.data.isLoading || state.isPaging) return;
    loadData(searchRequest: query.isNotEmpty ? query : null);
  }

  /// Загрузить данные списка видов.
  ///
  /// [resetOffset] — начать список заново (первая страница / обновление),
  /// иначе — догрузка следующей страницы к уже загруженным элементам.
  Future<void> loadData({required String? searchRequest, bool resetOffset = false}) async {
    Log.debug('SearchSpecCubit.loadData search=$searchRequest, resetOffset=$resetOffset');
    if (resetOffset) {
      safeEmit(state.copyWith(offset: 0, data: const DataState.loading(), isPaging: false));
    } else if (!state.data.isLoading) {
      safeEmit(state.copyWith(isPaging: true, pagingError: () => null));
    }

    try {
      // Уровень таксономии для запроса = уровень родителя + 1 (верхний = 1).
      final level = (parentSearch?.level ?? 0) + 1;
      final result = await _repository.listSpecies(
        level: level,
        parentId: parentSearch?.id,
        offset: state.offset,
        search: searchRequest,
        shelterId: _shelterProvider.shelterId,
      );
      final value = result.fold((failure) => throw failure, (species) => species);
      final list = [...(state.data.valueOrNull ?? <AnimalSpecies>[]), ...value];
      Log.info('SearchSpecCubit.loadData ok: ${value.length} new, ${list.length} total');
      safeEmit(
        state.copyWith(
          offset: state.offset + value.length,
          data: DataState.content(list),
          isPaging: false,
          pagingError: () => null,
        ),
      );
    } catch (error, s) {
      Log.error('SearchSpecCubit.loadData failed', error, s);
      if (state.data.isLoading) {
        safeEmit(state.copyWith(data: DataState.error(error), isPaging: false));
      } else {
        safeEmit(state.copyWith(isPaging: false, pagingError: () => error));
      }
    }
  }

  @override
  Future<void> close() {
    _bounceTimer?.cancel();
    return super.close();
  }
}

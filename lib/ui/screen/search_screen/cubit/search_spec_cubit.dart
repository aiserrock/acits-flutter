import 'dart:async';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/search_screen/cubit/search_spec_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _searchBouncePeriod = Duration(milliseconds: 1000);

/// Cubit экрана поиска вида животного.
///
/// Владеет состоянием списка видов ([DataState]), пагинацией и бизнес-логикой
/// поиска с дебаунсом. UI-контроллеры ([ScrollController], [TextEditingController])
/// остаются во [StatefulWidget] экрана.
class SearchSpecCubit extends Cubit<SearchSpecState> {
  SearchSpecCubit({this.parentSearch})
    : _service = getIt<AnimalService>(),
      super(const SearchSpecState()) {
    loadData(searchRequest: null, resetOffset: true);
  }

  final AnimalService _service;

  /// Родительский вид, внутри которого выполняется поиск (или null — верхний уровень).
  final Species? parentSearch;

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
    _bounceTimer = Timer(
      _searchBouncePeriod,
      () => loadData(searchRequest: query, resetOffset: true),
    );
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
    if (resetOffset) {
      safeEmit(state.copyWith(offset: 0, data: const DataState.loading(), isPaging: false));
    } else if (!state.data.isLoading) {
      safeEmit(state.copyWith(isPaging: true, pagingError: () => null));
    }

    try {
      final level = _service.getLevel(int.tryParse(parentSearch?.level.toString() ?? '0') ?? 0);
      final value = await _service.getAnimalSpecies(
        level: level,
        parentId: parentSearch?.id,
        offset: state.offset,
        searchRequest: searchRequest,
      );
      final list = [...(state.data.valueOrNull ?? <Species>[]), ...value];
      safeEmit(
        state.copyWith(
          offset: state.offset + value.length,
          data: DataState.content(list),
          isPaging: false,
          pagingError: () => null,
        ),
      );
    } catch (error) {
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

import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:equatable/equatable.dart';

/// Состояние экрана списка животных.
///
/// Держит основное состояние загрузки списка ([data]), состояние догрузки
/// следующей страницы ([page]) и флаг активного поиска ([isSearchActive]).
/// UI-контроллеры (ScrollController) остаются во [StatefulWidget] экрана.
class AnimalsState extends Equatable {
  const AnimalsState({
    this.data = const DataState.loading(),
    this.page = const DataState.content(0),
    this.isSearchActive = false,
  });

  /// Состояние основного списка животных.
  final DataState<List<AnimalRead>> data;

  /// Состояние догрузки очередной страницы (индикатор внизу списка).
  final DataState<int> page;

  /// Активен ли режим поиска в шапке экрана.
  final bool isSearchActive;

  AnimalsState copyWith({DataState<List<AnimalRead>>? data, DataState<int>? page, bool? isSearchActive}) {
    return AnimalsState(
      data: data ?? this.data,
      page: page ?? this.page,
      isSearchActive: isSearchActive ?? this.isSearchActive,
    );
  }

  @override
  List<Object?> get props => [data, page, isSearchActive];
}

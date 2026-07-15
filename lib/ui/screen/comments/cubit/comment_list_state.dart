import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:equatable/equatable.dart';

/// Состояние экрана списка комментариев к животному.
///
/// Держит основное состояние загрузки списка ([data]) и состояние догрузки
/// следующей страницы ([page], индикатор внизу списка). UI-контроллеры
/// (ScrollController) остаются во [StatefulWidget] экрана.
class CommentListState extends Equatable {
  const CommentListState({this.data = const DataState.loading(), this.page = const DataState.content(null)});

  /// Состояние основного списка комментариев.
  final DataState<List<AnimalNote>> data;

  /// Состояние догрузки очередной страницы (индикатор внизу списка).
  final DataState<Object?> page;

  CommentListState copyWith({DataState<List<AnimalNote>>? data, DataState<Object?>? page}) {
    return CommentListState(data: data ?? this.data, page: page ?? this.page);
  }

  @override
  List<Object?> get props => [data, page];
}

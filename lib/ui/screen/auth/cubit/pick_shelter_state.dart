import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:equatable/equatable.dart';

/// Состояние экрана выбора приюта.
///
/// [shelters] — список приютов для отрисовки (берётся из аргумента экрана или
/// из [AuthService]). [status] отражает жизненный цикл выбора приюта:
/// [DataContent] — список готов к отрисовке, [DataLoading] — идёт применение
/// выбранного приюта, [DataError] — применение упало (показываем ретрай).
class PickShelterState extends Equatable {
  const PickShelterState({this.shelters, this.status = const DataState.content(_idle)});

  static const Object _idle = Object();

  /// Список приютов, доступных пользователю.
  final PaginatedShelterShortSerializersList? shelters;

  /// Состояние применения выбранного приюта.
  final DataState<Object> status;

  /// Приюты, доступные для выбора (пустой список, если данные не загружены).
  List<ShelterShortSerializers> get results => shelters?.results ?? const [];

  PickShelterState copyWith({
    PaginatedShelterShortSerializersList? shelters,
    DataState<Object>? status,
  }) {
    return PickShelterState(shelters: shelters ?? this.shelters, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [shelters, status];
}

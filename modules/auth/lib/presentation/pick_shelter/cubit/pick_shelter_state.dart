import 'package:base/base.dart';
import 'package:acits_domain/acits_domain.dart';
import 'package:equatable/equatable.dart';

/// Состояние экрана выбора приюта.
///
/// [shelters] — список приютов для отрисовки (берётся из аргумента экрана или
/// из [AuthSessionApi]). [status] отражает жизненный цикл выбора приюта:
/// [DataContent] — список готов к отрисовке, [DataLoading] — идёт применение
/// выбранного приюта, [DataError] — применение упало (показываем ретрай).
class PickShelterState extends Equatable {
  const PickShelterState({this.shelters, this.status = const DataState.content(_idle)});

  static const Object _idle = Object();

  /// Список приютов, доступных пользователю.
  final List<Shelter>? shelters;

  /// Состояние применения выбранного приюта.
  final DataState<Object> status;

  /// Приюты, доступные для выбора (пустой список, если данные не загружены).
  List<Shelter> get results => shelters ?? const [];

  PickShelterState copyWith({List<Shelter>? shelters, DataState<Object>? status}) {
    return PickShelterState(shelters: shelters ?? this.shelters, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [shelters, status];
}

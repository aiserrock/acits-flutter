import 'package:equatable/equatable.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/util/data_state.dart';

/// Состояние экрана личного кабинета: данные пользователя ([data]) и признак
/// видимости кнопки сохранения ([fabVisible]).
class PersonalState extends Equatable {
  const PersonalState({required this.data, this.fabVisible = false});

  const PersonalState.loading() : this(data: const DataState.loading());

  final DataState<UserSerializers> data;
  final bool fabVisible;

  PersonalState copyWith({DataState<UserSerializers>? data, bool? fabVisible}) {
    return PersonalState(data: data ?? this.data, fabVisible: fabVisible ?? this.fabVisible);
  }

  @override
  List<Object?> get props => [data, fabVisible];
}

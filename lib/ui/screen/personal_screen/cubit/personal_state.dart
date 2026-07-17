import 'package:equatable/equatable.dart';

import 'package:acits_flutter/domain/user_profile.dart';
import 'package:acits_flutter/util/data_state.dart';

/// Состояние экрана личного кабинета: данные пользователя ([data]) и признак
/// видимости кнопки сохранения ([fabVisible]).
class PersonalState extends Equatable {
  const PersonalState({required this.data, this.fabVisible = false});

  const PersonalState.loading() : this(data: const DataState.loading());

  final DataState<UserProfile> data;
  final bool fabVisible;

  PersonalState copyWith({DataState<UserProfile>? data, bool? fabVisible}) {
    return PersonalState(data: data ?? this.data, fabVisible: fabVisible ?? this.fabVisible);
  }

  @override
  List<Object?> get props => [data, fabVisible];
}

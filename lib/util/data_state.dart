import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Иммутабельное состояние загрузки данных для Cubit/Bloc.
///
/// Замена мутабельного `ScreenDataState` из `screen_state.dart`. Три варианта:
/// [DataLoading], [DataContent], [DataError]. Используется как состояние
/// (или его часть) в Cubit'ах экранов вместе с [DataStateBuilder].
sealed class DataState<T> extends Equatable {
  const DataState();

  const factory DataState.loading() = DataLoading<T>;
  const factory DataState.content(T data) = DataContent<T>;
  const factory DataState.error(Object error) = DataError<T>;

  bool get isLoading => this is DataLoading<T>;
  bool get isContent => this is DataContent<T>;
  bool get hasError => this is DataError<T>;

  /// Данные, если состояние — [DataContent], иначе null.
  T? get valueOrNull => this is DataContent<T> ? (this as DataContent<T>).data : null;
}

class DataLoading<T> extends DataState<T> {
  const DataLoading();

  @override
  List<Object?> get props => const [];
}

class DataContent<T> extends DataState<T> {
  const DataContent(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

class DataError<T> extends DataState<T> {
  const DataError(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

/// Рендерит один из трёх коллбэков в зависимости от варианта [DataState].
///
/// Аналог старого `StateBuilder`, но поверх иммутабельного [DataState] —
/// удобно оборачивать в `BlocBuilder` селектором на поле состояния.
class DataStateBuilder<T> extends StatelessWidget {
  const DataStateBuilder({
    required this.state,
    required this.builder,
    required this.loader,
    required this.errorBuilder,
    super.key,
  });

  final DataState<T> state;
  final WidgetBuilder loader;
  final Widget Function(BuildContext context, Object error) errorBuilder;
  final Widget Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      DataLoading<T>() => loader(context),
      DataContent<T>(:final data) => builder(context, data),
      DataError<T>(:final error) => errorBuilder(context, error),
    };
  }
}

/// Удобный `BlocBuilder`, слушающий Cubit со состоянием-[DataState].
class DataStateConsumer<C extends StateStreamable<DataState<T>>, T> extends StatelessWidget {
  const DataStateConsumer({
    required this.builder,
    required this.loader,
    required this.errorBuilder,
    super.key,
  });

  final WidgetBuilder loader;
  final Widget Function(BuildContext context, Object error) errorBuilder;
  final Widget Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, DataState<T>>(
      builder: (context, state) => DataStateBuilder<T>(
        state: state,
        builder: builder,
        loader: loader,
        errorBuilder: errorBuilder,
      ),
    );
  }
}

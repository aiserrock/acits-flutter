import 'package:flutter/material.dart';

class ScreenState<T> {
  T? _value;
  Object? _error;
  bool _loading = false;

  T? get value => _value;
  bool get isLoading => _loading;
  bool get isContent => _value != null;
  bool get hasError => _error != null;

  Object? get error => _error;

  final state = Stream<T>.empty();

  void loading() {
    _value = null;
    _error = null;
    _loading = true;
  }

  void content(T data) {
    _value = data;
    _error = null;
    _loading = false;
  }

  set error(Object? error) {
    _value = null;
    _error = error;
    _loading = false;
  }
}

class ScreenStateBuilder<T> extends StatelessWidget {
  const ScreenStateBuilder({
    required this.state,
    required this.builder,
    required this.loader,
    required this.errorBuilder,
    Key? key,
  }) : super(key: key);

  final ScreenState<T> state;

  final WidgetBuilder loader;
  final Widget Function(BuildContext context, Object? error) errorBuilder;
  final Widget Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    return state.isContent
        ? builder(context, state._value!)
        : state.isLoading
            ? loader(context)
            : errorBuilder(context, state._error);
  }
}

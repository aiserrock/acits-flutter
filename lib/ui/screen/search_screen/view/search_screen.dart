import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/search_content.dart';
import 'package:acits_flutter/ui/screen/search_screen/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Экран поиска / выбора для объектов
/// [Curator], [AnimalRead], [Applicant]
class Search<T> extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Search({
    required this.adapter,
    this.tileBuilder,
    Key? key,
  }) : super(key: key);

  final PagingFetchAdapter adapter;
  final Widget Function(T item)? tileBuilder;

  static Route<T> route<T>({
    PagingFetchAdapter? adapter,
    Widget Function(T item)? tileBuilder,
  }) {
    final adapter = SearchAdapterTypeFactoryDelegate.adapter(T);
    final tileBuilder = SearchAdapterTypeFactoryDelegate.tileBuilder<T>();

    return MaterialPageRoute(
        builder: (_) => Search<T>(
              adapter: adapter,
              tileBuilder: tileBuilder,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc<T>(adapter: adapter),
      child: SearchContent<T>(tileBuilder: tileBuilder),
    );
  }
}

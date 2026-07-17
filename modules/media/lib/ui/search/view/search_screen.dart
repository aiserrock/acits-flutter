import 'package:acits_domain/acits_domain.dart' show Applicant, Curator, Shelter;
import 'package:animals/animals.dart' show AnimalListItem;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prescriptions/prescriptions.dart' show Drug;

import '../search.dart';
import 'search_content.dart';

/// Экран поиска / выбора для объектов
/// [Curator], [AnimalListItem], [Applicant]
class Search<T> extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Search({required this.adapter, this.tileBuilder, super.key});

  final PagingFetchAdapter adapter;
  final Widget Function(T item)? tileBuilder;

  /// Собрать [Search] по строковому ключу типа (для go_router `?type=`).
  /// См. [SearchTypeKey]. Возвращаемое значение — объект соответствующего типа
  /// ([AnimalListItem], [Applicant], [Curator], [Drug],
  /// [Shelter]); вызывающая сторона кастует результат push. [deps] — data-слой
  /// поиска, резолвится в корне (getIt) и передаётся сюда (модуль не тянет getIt
  /// для сервисов).
  static Widget byTypeKey(String typeKey, SearchDeps deps) {
    switch (typeKey) {
      case SearchTypeKey.animal:
        return Search<AnimalListItem>(
          adapter: AnimalFetchAdapter(deps),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<AnimalListItem>(),
        );
      case SearchTypeKey.applicant:
        return Search<Applicant>(
          adapter: ApplicantFetchAdapter(deps),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<Applicant>(),
        );
      case SearchTypeKey.curator:
        return Search<Curator>(
          adapter: CuratorFetchAdapter(deps),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<Curator>(),
        );
      case SearchTypeKey.drug:
        return Search<Drug>(
          adapter: DrugFetchAdapter(deps),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<Drug>(),
        );
      case SearchTypeKey.shelter:
        return Search<Shelter>(
          adapter: ShelterFetchAdapter(deps),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<Shelter>(),
        );
      default:
        throw ArgumentError('Unknown search type key: $typeKey');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc<T>(adapter: adapter),
      child: SearchContent<T>(tileBuilder: tileBuilder),
    );
  }
}

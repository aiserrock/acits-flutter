import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/search_content.dart';
import 'package:acits_flutter/ui/screen/search_screen/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Экран поиска / выбора для объектов
/// [Curator], [AnimalRead], [Applicant]
class Search<T> extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Search({required this.adapter, this.tileBuilder, super.key});

  final PagingFetchAdapter adapter;
  final Widget Function(T item)? tileBuilder;

  /// Собрать [Search] по строковому ключу типа (для go_router `?type=`).
  /// См. [SearchTypeKey]. Возвращаемое значение — объект соответствующего типа
  /// ([AnimalRead], [Applicant], [Curator], [ShelterDrug],
  /// [ShelterShortSerializers]); вызывающая сторона кастует результат push.
  static Widget byTypeKey(String typeKey) {
    switch (typeKey) {
      case SearchTypeKey.animal:
        return Search<AnimalRead>(
          adapter: AnimalReadFetchAdapter(),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<AnimalRead>(),
        );
      case SearchTypeKey.applicant:
        return Search<Applicant>(
          adapter: ApplicantFetchAdapter(),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<Applicant>(),
        );
      case SearchTypeKey.curator:
        return Search<Curator>(
          adapter: CuratorFetchAdapter(),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<Curator>(),
        );
      case SearchTypeKey.drug:
        return Search<ShelterDrug>(
          adapter: DrugFetchAdapter(),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<ShelterDrug>(),
        );
      case SearchTypeKey.shelter:
        return Search<ShelterShortSerializers>(
          adapter: ShelterFetchAdapter(),
          tileBuilder: SearchAdapterTypeFactoryDelegate.tileBuilder<ShelterShortSerializers>(),
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

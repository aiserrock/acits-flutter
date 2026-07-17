import 'package:acits_domain/acits_domain.dart' show Shelter;
import 'package:animals/animals.dart' show AnimalListItem, AnimalRepository;
import 'package:acits_flutter/ui/screen/search_screen/view/widget/drug_item.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/widget/shelter_item.dart';
import 'package:flutter/material.dart';

import 'package:applicants/applicants.dart' show StaffService;
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/widget/animal_item.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/widget/applicant_item.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/widget/curator_item.dart';

/// Строковые ключи для generic-поиска [Search] в go_router (поле `?type=`).
/// Нужны, т.к. Dart-тип `T` нельзя передать через URL-роут.
abstract final class SearchTypeKey {
  static const animal = 'animal';
  static const applicant = 'applicant';
  static const curator = 'curator';
  static const drug = 'drug';
  static const shelter = 'shelter';
}

class SearchAdapterTypeFactoryDelegate {
  static PagingFetchAdapter adapter(Type type) {
    switch (type) {
      case const (AnimalListItem):
        return AnimalFetchAdapter();
      case const (Applicant):
        return ApplicantFetchAdapter();
      case const (Curator):
        return CuratorFetchAdapter();
      case const (Drug):
        return DrugFetchAdapter();
      case const (Shelter):
        return ShelterFetchAdapter();
      default:
        throw UnimplementedError();
    }
  }

  static Widget Function(T) tileBuilder<T>() {
    switch (T) {
      case const (AnimalListItem):
        return AnimalSearchItem.builder as Widget Function(T);
      case const (Applicant):
        return ApplicantListItem.builder as Widget Function(T);
      case const (Curator):
        return CuratorListItem.builder as Widget Function(T);
      case const (Drug):
        return DrugListItem.builder as Widget Function(T);
      case const (Shelter):
        return ShelterListItem.builder as Widget Function(T);
      default:
        throw UnimplementedError();
    }
  }
}

abstract class PagingFetchAdapter<R> {
  PagingFetchAdapter(this.fetcher);

  final Future Function({int limit, int offset, String? searchRequest}) fetcher;

  Future<List<R>> fetch({required int limit, int offset = 0, String? search});
}

class AnimalFetchAdapter extends PagingFetchAdapter<AnimalListItem> {
  // fetcher не используется (репозиторий возвращает Result, а не paginated) —
  // передаём заглушку, чтобы удовлетворить базовый конструктор.
  AnimalFetchAdapter() : _repository = getIt<AnimalRepository>(), super(_unusedFetcher);

  final AnimalRepository _repository;

  static Future<dynamic> _unusedFetcher({int limit = 25, int offset = 0, String? searchRequest}) async => null;

  @override
  Future<List<AnimalListItem>> fetch({required int limit, int offset = 0, String? search}) async {
    final result = await _repository.list(
      shelterId: getIt<AuthService>().currentShelterId,
      search: search,
      limit: limit,
      offset: offset,
    );
    return result.fold((_) => <AnimalListItem>[], (items) => items);
  }
}

class ApplicantFetchAdapter extends PagingFetchAdapter<Applicant> {
  ApplicantFetchAdapter() : super(getIt<StaffService>().fetchApplicants);

  @override
  Future<List<Applicant>> fetch({required int limit, int offset = 0, String? search}) async {
    return fetcher.call(limit: limit, offset: offset, searchRequest: search).then((value) => value ?? <Applicant>[]);
  }
}

class CuratorFetchAdapter extends PagingFetchAdapter<Curator> {
  CuratorFetchAdapter() : super(getIt<StaffService>().fetchCurators);

  @override
  Future<List<Curator>> fetch({required int limit, int offset = 0, String? search}) async {
    return fetcher.call(limit: limit, offset: offset, searchRequest: search).then((value) => value ?? <Curator>[]);
  }
}

class DrugFetchAdapter extends PagingFetchAdapter<Drug> {
  DrugFetchAdapter() : super(getIt<PrescriptionService>().fetchDrugList);

  @override
  Future<List<Drug>> fetch({required int limit, int offset = 0, String? search}) async {
    return getIt<PrescriptionService>().fetchDrugList(limit: limit, offset: offset, searchRequest: search);
  }
}

class ShelterFetchAdapter extends PagingFetchAdapter<Shelter> {
  ShelterFetchAdapter() : super(getIt<AuthService>().getAllShelterList);

  @override
  Future<List<Shelter>> fetch({required int limit, int offset = 0, String? search}) async {
    return fetcher.call(limit: limit, offset: offset, searchRequest: search).then((value) => value ?? <Shelter>[]);
  }
}

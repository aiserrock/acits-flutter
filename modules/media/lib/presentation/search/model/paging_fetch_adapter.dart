import 'package:acits_domain/acits_domain.dart' show Applicant, Curator, Shelter;
import 'package:animals/animals.dart' show AnimalListItem, AnimalRepository;
import 'package:applicants/applicants.dart' show StaffService;
import 'package:flutter/material.dart';
import 'package:prescriptions/prescriptions.dart' show Drug, PrescriptionService;

import 'package:media/domain/domain.dart';
import 'package:media/presentation/search/view/widget/widget.dart';

/// Строковые ключи для generic-поиска [Search] в go_router (поле `?type=`).
/// Нужны, т.к. Dart-тип `T` нельзя передать через URL-роут.
abstract final class SearchTypeKey {
  static const animal = 'animal';
  static const applicant = 'applicant';
  static const curator = 'curator';
  static const drug = 'drug';
  static const shelter = 'shelter';
}

/// Зависимости generic-поиска, резолвятся в корне (getIt) и передаются в
/// фабрику адаптеров — так модуль не тянет `getIt` для сервисов, а data-слой
/// приезжает через конструктор (паттерн cubit-инъекции модулей).
class SearchDeps {
  const SearchDeps({
    required this.animalRepository,
    required this.staffService,
    required this.prescriptionService,
    required this.shelterProvider,
  });

  final AnimalRepository animalRepository;
  final StaffService staffService;
  final PrescriptionService prescriptionService;
  final MediaShelterProvider shelterProvider;
}

class SearchAdapterTypeFactoryDelegate {
  static PagingFetchAdapter adapter(Type type, SearchDeps deps) {
    switch (type) {
      case const (AnimalListItem):
        return AnimalFetchAdapter(deps);
      case const (Applicant):
        return ApplicantFetchAdapter(deps);
      case const (Curator):
        return CuratorFetchAdapter(deps);
      case const (Drug):
        return DrugFetchAdapter(deps);
      case const (Shelter):
        return ShelterFetchAdapter(deps);
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
  AnimalFetchAdapter(this._deps) : super(_unusedFetcher);

  final SearchDeps _deps;

  AnimalRepository get _repository => _deps.animalRepository;

  static Future<dynamic> _unusedFetcher({int limit = 25, int offset = 0, String? searchRequest}) async => null;

  @override
  Future<List<AnimalListItem>> fetch({required int limit, int offset = 0, String? search}) async {
    final result = await _repository.list(
      shelterId: _deps.shelterProvider.currentShelterId,
      search: search,
      limit: limit,
      offset: offset,
    );
    return result.fold((_) => <AnimalListItem>[], (items) => items);
  }
}

class ApplicantFetchAdapter extends PagingFetchAdapter<Applicant> {
  ApplicantFetchAdapter(SearchDeps deps) : super(deps.staffService.fetchApplicants);

  @override
  Future<List<Applicant>> fetch({required int limit, int offset = 0, String? search}) async {
    return fetcher.call(limit: limit, offset: offset, searchRequest: search).then((value) => value ?? <Applicant>[]);
  }
}

class CuratorFetchAdapter extends PagingFetchAdapter<Curator> {
  CuratorFetchAdapter(SearchDeps deps) : super(deps.staffService.fetchCurators);

  @override
  Future<List<Curator>> fetch({required int limit, int offset = 0, String? search}) async {
    return fetcher.call(limit: limit, offset: offset, searchRequest: search).then((value) => value ?? <Curator>[]);
  }
}

class DrugFetchAdapter extends PagingFetchAdapter<Drug> {
  DrugFetchAdapter(this._deps) : super(_deps.prescriptionService.fetchDrugList);

  final SearchDeps _deps;

  @override
  Future<List<Drug>> fetch({required int limit, int offset = 0, String? search}) async {
    return _deps.prescriptionService.fetchDrugList(limit: limit, offset: offset, searchRequest: search);
  }
}

class ShelterFetchAdapter extends PagingFetchAdapter<Shelter> {
  ShelterFetchAdapter(SearchDeps deps) : super(deps.shelterProvider.getAllShelterList);

  @override
  Future<List<Shelter>> fetch({required int limit, int offset = 0, String? search}) async {
    return fetcher.call(limit: limit, offset: offset, searchRequest: search).then((value) => value ?? <Shelter>[]);
  }
}

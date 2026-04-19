import 'package:acits_flutter/ui/screen/search_screen/view/widget/drug_item.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/widget/shelter_item.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/widget/animal_item.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/widget/applicant_item.dart';
import 'package:acits_flutter/ui/screen/search_screen/view/widget/curator_item.dart';

class SearchAdapterTypeFactoryDelegate {
  static PagingFetchAdapter adapter(Type type) {
    switch (type) {
      case AnimalRead:
        return AnimalReadFetchAdapter();
      case Applicant:
        return ApplicantFetchAdapter();
      case Curator:
        return CuratorFetchAdapter();
      case ShelterDrug:
        return DrugFetchAdapter();
      case ShelterShortSerializers:
        return ShelterFetchAdapter();
      default:
        throw UnimplementedError();
    }
  }

  static Widget Function(T) tileBuilder<T>() {
    switch (T) {
      case AnimalRead:
        return AnimalListItem.builder as Widget Function(T);
      case Applicant:
        return ApplicantListItem.builder as Widget Function(T);
      case Curator:
        return CuratorListItem.builder as Widget Function(T);
      case ShelterDrug:
        return DrugListItem.builder as Widget Function(T);
      case ShelterShortSerializers:
        return ShelterListItem.builder as Widget Function(T);
      default:
        throw UnimplementedError();
    }
  }
}

abstract class PagingFetchAdapter<R> {
  @mustCallSuper
  PagingFetchAdapter(this.fetcher);

  final Future Function({
    int limit,
    int offset,
    String? searchRequest,
  }) fetcher;

  Future<List<R>> fetch({
    required int limit,
    int offset = 0,
    String? search,
  });
}

class AnimalReadFetchAdapter extends PagingFetchAdapter<AnimalRead> {
  AnimalReadFetchAdapter() : super(getIt<AnimalService>().fetchAnimalList);

  @override
  Future<List<AnimalRead>> fetch({
    required int limit,
    int offset = 0,
    String? search,
  }) async {
    return fetcher
        .call(
          limit: limit,
          offset: offset,
          searchRequest: search,
        )
        .then((value) => value?.results ?? <AnimalRead>[]);
  }
}

class ApplicantFetchAdapter extends PagingFetchAdapter<Applicant> {
  ApplicantFetchAdapter() : super(getIt<StaffService>().fetchApplicants);

  @override
  Future<List<Applicant>> fetch({
    required int limit,
    int offset = 0,
    String? search,
  }) async {
    return fetcher
        .call(
          limit: limit,
          offset: offset,
          searchRequest: search,
        )
        .then((value) => value ?? <Applicant>[]);
  }
}

class CuratorFetchAdapter extends PagingFetchAdapter<Curator> {
  CuratorFetchAdapter() : super(getIt<StaffService>().fetchCurators);

  @override
  Future<List<Curator>> fetch({
    required int limit,
    int offset = 0,
    String? search,
  }) async {
    return fetcher
        .call(
          limit: limit,
          offset: offset,
          searchRequest: search,
        )
        .then((value) => value ?? <Curator>[]);
  }
}

class DrugFetchAdapter extends PagingFetchAdapter<ShelterDrug> {
  DrugFetchAdapter() : super(getIt<PrescriptionService>().fetchDrugList);

  @override
  Future<List<ShelterDrug>> fetch({
    required int limit,
    int offset = 0,
    String? search,
  }) async {
    return fetcher
        .call(
          limit: limit,
          offset: offset,
          searchRequest: search,
        )
        .then((value) => value?.results ?? <ShelterDrug>[]);
  }
}

class ShelterFetchAdapter extends PagingFetchAdapter<ShelterShortSerializers> {
  ShelterFetchAdapter() : super(getIt<AuthService>().getAllShelterList);

  @override
  Future<List<ShelterShortSerializers>> fetch({
    required int limit,
    int offset = 0,
    String? search,
  }) async {
    return fetcher
        .call(
          limit: limit,
          offset: offset,
          searchRequest: search,
        )
        .then((value) => value?.results ?? <ShelterShortSerializers>[]);
  }
}

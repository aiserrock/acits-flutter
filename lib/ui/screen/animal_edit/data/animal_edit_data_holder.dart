import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class AnimalEditHolder extends ChangeNotifier {
  AnimalRead? _initState;

  AnimalRead _state = AnimalRead(
    images: const [],
    dateJoined: DateTime.now(),
    placeOfCatch: '',
    shelter: 0,
    animalAttributes: const [],
  );

  void init(AnimalRead animal) {
    _initState = _state = animal;
    notifyListeners();
  }

  void set(AnimalRead animal) {
    if (_state != animal) {
      _state = animal;
      notifyListeners();
    }
  }

  AnimalRead get state => _state;

  bool get isEdited => _initState != null ? _initState != _state : false;

  void copyWith({
    String? url,
    String? name,
    dynamic spec,
    Status69fEnum? status,
    DateTime? dateJoined,
    DateTime? birthDate,
    DateTime? deathDate,
    String? deathReason,
    String? placeOfCatch,
    String? placeOfRelease,
    DateTime? dateOfChipping,
    String? chippingCode,
    String? height,
    String? weight,
    bool? hasDocuments,
    int? shelter,
    Curator? curator,
    Applicant? applicant,
    int? applicantId,
    List<AnimalAttributeValue>? animalAttributes,
    DateTime? deletedAt,
    List<AnimalImageRead>? images,
  }) {
    final animal = AnimalRead(
      id: _state.id,
      url: url ?? _state.url,
      name: name ?? _state.name,
      images: images ?? _state.images,
      spec: spec ?? _state.spec,
      status: status ?? _state.status,
      dateJoined: dateJoined ?? _state.dateJoined,
      birthDate: birthDate ?? _state.birthDate,
      deathDate: deathDate ?? _state.deathDate,
      deathReason: deathReason ?? _state.deathReason,
      placeOfCatch: placeOfCatch ?? _state.placeOfCatch,
      placeOfRelease: placeOfRelease ?? _state.placeOfRelease,
      dateOfChipping: dateOfChipping ?? _state.dateOfChipping,
      chippingCode: chippingCode ?? _state.chippingCode,
      height: height ?? _state.height,
      weight: weight ?? _state.weight,
      hasDocuments: hasDocuments ?? _state.hasDocuments,
      shelter: shelter ?? _state.shelter,
      curator: curator ?? _state.curator,
      applicant: applicant ?? _state.applicant,
      animalAttributes: animalAttributes ?? _state.animalAttributes,
      deletedAt: deletedAt ?? _state.deletedAt,
    );
    set(animal);
  }
}

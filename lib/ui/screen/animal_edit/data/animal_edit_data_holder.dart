import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class AnimalEditHolder extends ChangeNotifier {
  Animal? _initState;

  Animal _state = Animal();

  init(Animal animal) {
    _initState = _state = animal;
    notifyListeners();
  }

  void set(Animal animal) {
    if (_state != animal) {
      _state = animal;
      notifyListeners();
    }
  }

  Animal get state => _state;

  bool get isEdited => _initState != null ? _initState != _state : false;

  void copyWith({
    String? url,
    String? name,
    String? avatar,
    String? avatarFilename,
    dynamic spec,
    int? specId,
    Status131Enum? status,
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
    dynamic curator,
    int? curatorId,
    dynamic applicant,
    int? applicantId,
    List<AnimalAttributeValue>? animalAttributes,
    DateTime? deletedAt,
  }) {
    final animal = Animal(
        id: _state.id,
        url: url ?? _state.url,
        name: name ?? _state.name,
        avatar: avatar ?? _state.avatar,
        avatarFilename: avatarFilename ?? _state.avatarFilename,
        spec: spec ?? _state.spec,
        specId: specId ?? _state.specId,
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
        curatorId: curatorId ?? _state.curatorId,
        applicant: applicant ?? _state.applicant,
        applicantId: applicantId ?? _state.applicantId,
        animalAttributes: animalAttributes ?? _state.animalAttributes,
        deletedAt: deletedAt ?? _state.deletedAt);
    set(animal);
  }
}

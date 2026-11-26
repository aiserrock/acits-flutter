import 'package:core/domain.dart' show Applicant, Curator;
import 'package:animals/animals.dart';
import 'package:flutter/material.dart';

/// Рабочее состояние формы редактирования животного в доменных типах.
///
/// Мультистраничная форма мутирует это состояние по одному блоку за раз
/// (см. `onChangePage` каждой страницы). Раньше холдер держал chopper-`AnimalRead`
/// (strangler-шов); теперь — только доменные поля, которые собирают страницы,
/// плюс seed-данные (фото/вид/атрибуты), нужные для отображения и сборки submit.
@immutable
class AnimalEditFormState {
  const AnimalEditFormState({
    this.name = '',
    this.specId,
    this.specCategoryName,
    this.specParentName,
    this.specKindName,
    this.status = AnimalStatus.unknown,
    this.dateJoined,
    this.placeOfCatch = '',
    this.birthDate,
    this.height,
    this.weight,
    this.chippingCode,
    this.dateOfChipping,
    this.attributes = const [],
    this.curator,
    this.applicant,
    this.images = const [],
    this.shelterId = 0,
    this.canBeShared = false,
  });

  final String name;

  /// Выбранный вид (id) + его отображаемые части (категория/семейство/вид).
  final int? specId;
  final String? specCategoryName;
  final String? specParentName;
  final String? specKindName;

  final AnimalStatus status;
  final DateTime? dateJoined;
  final String placeOfCatch;
  final DateTime? birthDate;
  final String? height;
  final String? weight;
  final String? chippingCode;
  final DateTime? dateOfChipping;

  /// Явные атрибуты (sex/color/special_signs …) с attrId/isRequired.
  final List<AnimalAttributeInput> attributes;

  final Curator? curator;
  final Applicant? applicant;

  /// Уже загруженные фото (для аватара + retain при сохранении).
  final List<AnimalImage> images;

  final int shelterId;
  final bool canBeShared;

  /// URL аватара (первичное фото → первое доступное).
  String? get thumb {
    if (images.isEmpty) return null;
    for (final image in images) {
      if (image.isPrimary) return image.thumb;
    }
    return images.first.thumb;
  }

  AnimalEditFormState copyWith({
    String? name,
    int? specId,
    String? specCategoryName,
    String? specParentName,
    String? specKindName,
    AnimalStatus? status,
    DateTime? dateJoined,
    String? placeOfCatch,
    DateTime? birthDate,
    String? height,
    String? weight,
    String? chippingCode,
    DateTime? dateOfChipping,
    List<AnimalAttributeInput>? attributes,
    Curator? curator,
    Applicant? applicant,
    List<AnimalImage>? images,
    int? shelterId,
    bool? canBeShared,
  }) {
    return AnimalEditFormState(
      name: name ?? this.name,
      specId: specId ?? this.specId,
      specCategoryName: specCategoryName ?? this.specCategoryName,
      specParentName: specParentName ?? this.specParentName,
      specKindName: specKindName ?? this.specKindName,
      status: status ?? this.status,
      dateJoined: dateJoined ?? this.dateJoined,
      placeOfCatch: placeOfCatch ?? this.placeOfCatch,
      birthDate: birthDate ?? this.birthDate,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      chippingCode: chippingCode ?? this.chippingCode,
      dateOfChipping: dateOfChipping ?? this.dateOfChipping,
      attributes: attributes ?? this.attributes,
      curator: curator ?? this.curator,
      applicant: applicant ?? this.applicant,
      images: images ?? this.images,
      shelterId: shelterId ?? this.shelterId,
      canBeShared: canBeShared ?? this.canBeShared,
    );
  }

  /// Доменная сущность [Animal] со скалярами формы (для submit). Атрибуты/фото
  /// передаются отдельно (репозиторий собирает write-DTO).
  Animal toAnimal() => Animal(
    id: 0,
    name: name,
    shelterId: shelterId,
    status: status,
    images: const [],
    attributes: const {},
    speciesId: specId,
    speciesName: specKindName,
    speciesParentName: specParentName,
    speciesCategoryName: specCategoryName,
    birthDate: birthDate,
    dateJoined: dateJoined,
    dateOfChipping: dateOfChipping,
    chippingCode: chippingCode,
    height: height,
    weight: weight,
    placeOfCatch: placeOfCatch,
    curator: curator == null ? null : AnimalContact(id: curator!.id ?? 0, firstName: '', lastName: ''),
    applicant: applicant == null ? null : AnimalContact(id: applicant!.id ?? 0, firstName: '', lastName: ''),
    canBeShared: canBeShared,
  );

  /// id уже загруженных фото, которые сохраняем при записи.
  List<int> get retainImageIds => images.map<int?>((e) => e.id).nonNulls.toList();
}

/// Держатель состояния формы (ChangeNotifier). Страницы читают [state] и
/// применяют изменения через [update].
class AnimalEditHolder extends ChangeNotifier {
  AnimalEditFormState? _initState;
  AnimalEditFormState _state = const AnimalEditFormState();

  AnimalEditFormState get state => _state;

  bool get isEdited => _initState != null ? _initState != _state : false;

  /// Инициализация формы доменной сущностью [animal] (seed при загрузке).
  void init(Animal animal) {
    _initState = _state = _seedFrom(animal);
    notifyListeners();
  }

  /// Применяет частичное изменение [mutate] к текущему состоянию.
  void update(AnimalEditFormState Function(AnimalEditFormState prev) mutate) {
    final next = mutate(_state);
    if (next != _state) {
      _state = next;
      notifyListeners();
    }
  }

  static AnimalEditFormState _seedFrom(Animal animal) {
    final attributes = animal.attributes.entries
        .map((e) => AnimalAttributeInput(attrId: 0, name: e.key, value: e.value))
        .toList();
    return AnimalEditFormState(
      name: animal.name,
      specId: animal.speciesId,
      specCategoryName: animal.speciesCategoryName,
      specParentName: animal.speciesParentName,
      specKindName: animal.speciesName,
      status: animal.status,
      dateJoined: animal.dateJoined ?? DateTime.now(),
      placeOfCatch: animal.placeOfCatch ?? '',
      birthDate: animal.birthDate,
      height: animal.height,
      weight: animal.weight,
      chippingCode: animal.chippingCode,
      dateOfChipping: animal.dateOfChipping,
      attributes: attributes,
      curator: _curatorOf(animal.curator),
      applicant: _applicantOf(animal.applicant),
      images: animal.images,
      shelterId: animal.shelterId,
      canBeShared: animal.canBeShared,
    );
  }

  static Curator? _curatorOf(AnimalContact? c) {
    if (c == null) return null;
    return Curator(
      id: c.id,
      firstName: c.firstName,
      lastName: c.lastName,
      phoneNumber: c.phoneNumber ?? '',
      email: c.email,
      address: c.extra,
    );
  }

  static Applicant? _applicantOf(AnimalContact? a) {
    if (a == null) return null;
    return Applicant(
      id: a.id,
      firstName: a.firstName,
      lastName: a.lastName,
      phoneNumber: a.phoneNumber ?? '',
      email: a.email,
      contactDetails: a.extra,
    );
  }
}

import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animals/domain/domain.dart';
import 'package:animals/presentation/animal_edit/animal_edit.dart';

/// Cubit экрана создания/редактирования животного.
///
/// Владеет write-путём через [AnimalRepository] (Result, без DTO): грузит
/// сущность [Animal] по id и отправляет create/update. Форма (мультистраничный
/// UI, контроллеры, `AnimalEditHolder`) остаётся в корневом экране — это
/// strangler-граница; она собирает доменные входные данные и передаёт их сюда,
/// а сборку `AnimalWriteDto` делает репозиторий. `AnimalRead` в модуль не течёт.
class AnimalEditCubit extends Cubit<DataState<AnimalEditContent>> {
  AnimalEditCubit(this._repository, this._shelterProvider, {this.id})
    : super(const DataState.content(AnimalEditContent())) {
    _load();
  }

  final AnimalRepository _repository;
  final CurrentShelterProvider _shelterProvider;
  final int? id;

  /// Режим редактирования (id задан) против создания.
  bool get isEdit => id != null;

  void _safeEmit(DataState<AnimalEditContent> state) {
    if (isClosed) return;
    emit(state);
  }

  /// Перезагрузить животное (pull-to-refresh в режиме редактирования).
  Future<void> reload() => _load();

  Future<void> _load() async {
    if (!isEdit) return;
    _safeEmit(const DataState.loading());
    final result = await _repository.getById(id!, shelterId: _shelterProvider.shelterId);
    result.fold(
      (failure) => _safeEmit(DataState.error(failure)),
      (animal) => _safeEmit(DataState.content(AnimalEditContent(animal: animal))),
    );
  }

  /// Сбрасывает экран из состояния ошибки обратно к форме.
  void resetToForm() {
    _safeEmit(const DataState.content(AnimalEditContent()));
  }

  /// Отправляет форму: создаёт или обновляет животное через репозиторий.
  ///
  /// [animal] несёт скалярные поля формы (имя/статус/даты/место/габариты/
  /// куратор/заявитель); атрибуты и фото передаются явно, т.к. плоская карта
  /// [Animal.attributes] теряет `attrId`/`isRequired`, а новые фото (base64) в
  /// сущности не живут. [specId] — выбранный вид (обязателен на запись).
  ///
  /// Возвращает `true` при успехе (экран переходит в [AnimalEditMode.success]).
  Future<bool> submit(
    Animal animal, {
    required List<AnimalAttributeInput> attributes,
    List<AnimalImageInput> newImages = const [],
    List<int> retainImageIds = const [],
    int? specId,
  }) async {
    final withSpec = specId != null ? _withSpecies(animal, specId) : animal;
    final result = isEdit
        ? await _repository.update(
            id!,
            withSpec,
            attributes: attributes,
            newImages: newImages,
            retainImageIds: retainImageIds,
            shelterId: _shelterProvider.shelterId,
          )
        : await _repository.create(
            withSpec,
            attributes: attributes,
            newImages: newImages,
            retainImageIds: retainImageIds,
            shelterId: _shelterProvider.shelterId,
          );
    return result.fold(
      (failure) {
        _safeEmit(DataState.error(failure));
        return false;
      },
      (_) {
        _safeEmit(const DataState.content(AnimalEditContent(mode: AnimalEditMode.success)));
        return true;
      },
    );
  }

  /// Возвращает копию [animal] с явно выбранным `speciesId` (write-mapper берёт
  /// specId из сущности). Остальные поля не трогаем.
  Animal _withSpecies(Animal animal, int specId) => Animal(
    id: animal.id,
    name: animal.name,
    shelterId: animal.shelterId,
    status: animal.status,
    images: animal.images,
    attributes: animal.attributes,
    speciesId: specId,
    speciesName: animal.speciesName,
    speciesParentName: animal.speciesParentName,
    speciesCategoryName: animal.speciesCategoryName,
    birthDate: animal.birthDate,
    dateJoined: animal.dateJoined,
    dateOfChipping: animal.dateOfChipping,
    chippingCode: animal.chippingCode,
    height: animal.height,
    weight: animal.weight,
    placeOfCatch: animal.placeOfCatch,
    placeOfRelease: animal.placeOfRelease,
    curator: animal.curator,
    applicant: animal.applicant,
    canBeShared: animal.canBeShared,
  );
}

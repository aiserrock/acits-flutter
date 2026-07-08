import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/animal.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/cubit/animal_edit_state.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

/// Cubit экрана создания/редактирования животного.
///
/// Владеет состоянием загрузки [DataState] и бизнес-логикой (загрузка по id,
/// создание, обновление, признак успеха). UI-контроллеры (`PageController`,
/// `TextEditingController`, ключи форм) и form-holder'ы ([AnimalEditHolder],
/// [AnimalEditPagerHolder]) остаются во [StatefulWidget] экрана.
class AnimalEditCubit extends Cubit<DataState<AnimalEditContent>> {
  AnimalEditCubit({this.id})
    : _animalService = getIt<AnimalService>(),
      super(const DataState.content(AnimalEditContent())) {
    _init();
  }

  final AnimalService _animalService;
  final int? id;

  /// Режим редактирования (id задан) против создания.
  bool get isEdit => id != null;

  /// Загружает животное по id в режиме редактирования.
  ///
  /// При успехе кладёт в контент загруженное [AnimalRead], чтобы экран мог
  /// проинициализировать `AnimalEditHolder`.
  Future<void> reload() => _init();

  Future<void> _init() async {
    if (!isEdit) return;
    safeEmit(const DataState.loading());
    try {
      final animal = await _animalService.fetchAnimalDetail(id: id!);
      safeEmit(DataState.content(AnimalEditContent(animal: animal)));
    } catch (e) {
      safeEmit(DataState.error(e));
    }
  }

  /// Сбрасывает экран из состояния ошибки обратно к форме.
  void resetToForm() {
    safeEmit(const DataState.content(AnimalEditContent()));
  }

  /// Отправляет форму: создаёт или обновляет животное.
  ///
  /// Возвращает `true` при успешном сохранении (экран переходит в режим
  /// [AnimalEditScreenMode.success]), иначе `false`.
  Future<bool> submit(AnimalRead editedAnimal) async {
    final isEditRequest = isEdit && editedAnimal.id != null;
    AnimalRead? result;
    try {
      result = isEditRequest
          ? await _animalService.updateAnimal(editedAnimal.id!, editedAnimal.write)
          : await _animalService.createAnimal(editedAnimal.write);
    } catch (e) {
      safeEmit(DataState.error(e));
      return false;
    }
    if (result != null) {
      safeEmit(const DataState.content(AnimalEditContent(mode: AnimalEditScreenMode.success)));
      return true;
    }
    return false;
  }
}

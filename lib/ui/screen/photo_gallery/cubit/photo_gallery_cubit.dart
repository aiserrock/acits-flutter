import 'dart:typed_data';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/gallery_item_data.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/cubit/photo_gallery_state.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/widget/gallery_item_data_x.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

/// Набор пресетных аватарок-заготовок, добавляемых в галерею.
final _galleryImageSet = [
  Assets.gallery.avatarAlpaka,
  Assets.gallery.avatarCat0,
  Assets.gallery.avatarCat1,
  Assets.gallery.avatarDog,
  Assets.gallery.avatarDolphin,
  Assets.gallery.avatarEagle,
  Assets.gallery.avatarMouse,
];

/// Cubit экрана выбора фотографий животного.
///
/// Владеет состоянием загрузки списка изображений и бизнес-логикой выбора,
/// добавления фото и сохранения. UI-контроллеры (Scaffold/Scroll) остаются во
/// [StatefulWidget] экрана.
class PhotoGalleryCubit extends Cubit<PhotoGalleryState> {
  PhotoGalleryCubit({required this.animalId})
    : _animalService = getIt<AnimalService>(),
      super(const PhotoGalleryState.loading()) {
    _init();
  }

  final AnimalService _animalService;

  /// ID животного, чьи фотографии редактируются.
  final int animalId;

  /// Загружает изображения животного и добавляет пресетные аватарки.
  Future<void> _init() async {
    Log.debug('PhotoGalleryCubit._init animalId=$animalId');
    safeEmit(state.copyWith(data: const DataState.loading()));
    try {
      final animal = await _animalService.fetchAnimalDetail(id: animalId);
      final items = <GalleryItemData>[
        ...animal.images.map<GalleryItemData>((e) => GalleryItemData.fromAnimalImage(e)),
        ..._galleryImageSet.map<GalleryItemData>((e) => GalleryItemData(assetPath: e.path)),
      ];
      Log.info('PhotoGalleryCubit._init ok: ${items.length} items');
      safeEmit(state.copyWith(data: DataState.content(items)));
    } catch (e, s) {
      Log.error('PhotoGalleryCubit._init failed', e, s);
      safeEmit(state.copyWith(data: DataState.error(e)));
    }
  }

  /// Повторная загрузка после ошибки.
  Future<void> reload() => _init();

  /// Инвертирует выбор изображения [item].
  void chooseItem(GalleryItemData item) {
    final currentList = state.data.valueOrNull;
    if (currentList == null) return;
    final index = currentList.indexOf(item);
    if (index < 0) return;
    final updated = List<GalleryItemData>.of(currentList);
    updated[index] = item.copyWith(isChoosed: !item.isChoosed);
    safeEmit(state.copyWith(data: DataState.content(updated), isSelectorChanged: true));
  }

  /// Добавляет новое фото с камеры или из галереи и помечает его выбранным.
  ///
  /// [edit] — коллбэк редактора (зум/поворот/кроп), вызывается сразу после
  /// выбора. Открывается из UI-слоя (нужен BuildContext), поэтому передаётся
  /// сюда как функция. Вернул `null` (отмена) — фото не добавляем.
  Future<void> addPhoto(ImageSource source, {required Future<Uint8List?> Function(Uint8List) edit}) async {
    final currentList = state.data.valueOrNull;
    if (currentList == null) return;
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile == null) return;
    // Читаем байты кроссплатформенно (работает и в web) сразу при выборе —
    // при сабмите File(path).readAsBytesSync() падал бы на web.
    final bytes = await xFile.readAsBytes();
    final edited = await edit(bytes);
    if (edited == null) return; // отмена в редакторе
    final updated = List<GalleryItemData>.of(currentList)
      ..insert(0, GalleryItemData(filePath: xFile.path, bytes: edited, isChoosed: true));
    safeEmit(state.copyWith(data: DataState.content(updated), isSelectorChanged: true));
  }

  /// Открывает редактор для уже добавленного фото [item] (у него должны быть
  /// [GalleryItemData.bytes]) и заменяет его отредактированными байтами.
  Future<void> editPhoto(GalleryItemData item, {required Future<Uint8List?> Function(Uint8List) edit}) async {
    final currentList = state.data.valueOrNull;
    if (currentList == null) return;
    final bytes = item.bytes;
    if (bytes == null) return; // редактируемы только фото с исходными байтами
    final index = currentList.indexOf(item);
    if (index < 0) return;
    final edited = await edit(bytes);
    if (edited == null) return; // отмена
    final updated = List<GalleryItemData>.of(currentList)..[index] = item.copyWith(bytes: edited, isChoosed: true);
    safeEmit(state.copyWith(data: DataState.content(updated), isSelectorChanged: true));
  }

  /// Количество выбранных изображений в текущем состоянии.
  int get choosedCount => state.data.valueOrNull?.countChoosedItems ?? 0;

  /// Сохраняет выбранные фотографии животного.
  ///
  /// Возвращает `true` при успехе, `false` при ошибке (состояние переводится в
  /// ошибку).
  Future<bool> submit() async {
    final list = state.data.valueOrNull;
    if (list == null) return false;
    Log.debug('PhotoGalleryCubit.submit animalId=$animalId, chosen=$choosedCount');
    safeEmit(state.copyWith(data: const DataState.loading()));
    try {
      await _animalService.changeAnimalPhotos(animalId, list);
      Log.info('PhotoGalleryCubit.submit ok: animalId=$animalId');
      return true;
    } catch (e, s) {
      Log.error('PhotoGalleryCubit.submit failed', e, s);
      safeEmit(state.copyWith(data: DataState.error(e)));
      return false;
    }
  }
}

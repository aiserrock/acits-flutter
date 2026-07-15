import 'dart:typed_data';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/gallery_item_data.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/cubit/photo_gallery_state.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/widget/gallery_item_data_x.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:dio/dio.dart';
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

  /// Открывает редактор для уже добавленного фото [item] и заменяет его
  /// отредактированными байтами.
  ///
  /// Для фото с устройства берём готовые [GalleryItemData.bytes]. Для уже
  /// загруженного сетевого фото докачиваем оригинал (large) в байты. После
  /// правки сетевого фото сбрасываем [GalleryItemData.network] в null — при
  /// сабмите оно уйдёт как новое изображение, а старый оригинал исключается из
  /// valid_images (заменяется отредактированным).
  Future<void> editPhoto(GalleryItemData item, {required Future<Uint8List?> Function(Uint8List) edit}) async {
    final currentList = state.data.valueOrNull;
    if (currentList == null) return;
    final index = currentList.indexOf(item);
    if (index < 0) return;

    var source = item.bytes;
    final isNetwork = source == null && item.network != null;
    if (isNetwork) {
      source = await _downloadImageBytes(item.network!.image.large);
      if (source == null) return; // не удалось скачать оригинал
    }
    if (source == null) return; // нечего редактировать (пресет)

    final edited = await edit(source);
    if (edited == null) return; // отмена

    // Сетевое фото после правки становится новым локальным (network=null,
    // остаётся filePath как имя) — так оно перезальётся, а оригинал не попадёт
    // в retain. copyWith не умеет обнулять network, пересобираем явно.
    final replacement = isNetwork
        ? GalleryItemData(filePath: item.network!.filename ?? 'edited.png', bytes: edited, isChoosed: true)
        : item.copyWith(bytes: edited, isChoosed: true);

    final updated = List<GalleryItemData>.of(currentList)..[index] = replacement;
    safeEmit(state.copyWith(data: DataState.content(updated), isSelectorChanged: true));
  }

  /// Докачивает байты изображения по [url] (кроссплатформенно, с CORS-прокси
  /// для web). Возвращает null при ошибке.
  Future<Uint8List?> _downloadImageBytes(String? url) async {
    final proxied = UrlCorsProxy.add(url);
    if (proxied == null || proxied.isEmpty) return null;
    try {
      // Отдельный «голый» Dio: presigned S3-URL самодостаточен, интерцепторы и
      // API-база основного клиента здесь только помешали бы.
      final resp = await Dio().get<List<int>>(proxied, options: Options(responseType: ResponseType.bytes));
      final data = resp.data;
      if (resp.statusCode != 200 || data == null) {
        Log.warning('Download image failed: ${resp.statusCode} $url');
        return null;
      }
      return Uint8List.fromList(data);
    } catch (e, s) {
      Log.error('Download image error', e, s);
      return null;
    }
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

import 'dart:convert';
import 'dart:math';

import 'package:base/base.dart';
import 'package:acits_domain/acits_domain.dart' show MessagedException;
import 'package:animals/animals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as image_util;
import 'package:image_picker/image_picker.dart';

import 'package:media/domain/domain.dart';
import 'package:media/presentation/presentation.dart';
import 'package:media/util/util.dart';

const _maxAnimalImageSize = 1024;

/// Набор пресетных аватарок-заготовок, добавляемых в галерею.
final _galleryImageSet = MediaAssets.galleryAvatars;

/// Cubit экрана выбора фотографий животного.
///
/// Владеет состоянием загрузки списка изображений и бизнес-логикой выбора,
/// добавления фото и сохранения. UI-контроллеры (Scaffold/Scroll) остаются во
/// [StatefulWidget] экрана.
class PhotoGalleryCubit extends Cubit<PhotoGalleryState> {
  PhotoGalleryCubit(this._repository, this._shelterProvider, {required this.animalId})
    : super(const PhotoGalleryState.loading()) {
    _init();
  }

  final AnimalRepository _repository;
  final CurrentShelterProvider _shelterProvider;

  /// ID животного, чьи фотографии редактируются.
  final int animalId;

  /// Загружает изображения животного и добавляет пресетные аватарки.
  Future<void> _init() async {
    Log.debug('PhotoGalleryCubit._init animalId=$animalId');
    safeEmit(state.copyWith(data: const DataState.loading()));
    final result = await _repository.getById(animalId, shelterId: _shelterProvider.shelterId);
    result.fold(
      (failure) {
        Log.warning('PhotoGalleryCubit._init failed: $failure');
        safeEmit(state.copyWith(data: DataState.error(failure)));
      },
      (animal) {
        final items = <GalleryItemData>[
          ...animal.images.map<GalleryItemData>((e) => GalleryItemData.fromAnimalImage(e)),
          ..._galleryImageSet.map<GalleryItemData>((e) => GalleryItemData(assetPath: e)),
        ];
        Log.info('PhotoGalleryCubit._init ok: ${items.length} items');
        safeEmit(state.copyWith(data: DataState.content(items)));
      },
    );
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
      source = await _downloadImageBytes(item.network!.large);
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
      final retainImageIds = <int>[];
      for (final e in list.where((e) => e.network != null && e.isChoosed)) {
        retainImageIds.add(e.network?.id ?? -1);
      }
      final newImages = await _buildNewImages(list);
      final result = await _repository.updatePhotos(
        animalId,
        newImages: newImages,
        retainImageIds: retainImageIds,
        shelterId: _shelterProvider.shelterId,
      );
      return result.fold(
        (failure) {
          Log.error('PhotoGalleryCubit.submit failed: $failure');
          safeEmit(state.copyWith(data: DataState.error(failure)));
          return false;
        },
        (_) {
          Log.info('PhotoGalleryCubit.submit ok: animalId=$animalId');
          return true;
        },
      );
    } catch (e, s) {
      Log.error('PhotoGalleryCubit.submit failed', e, s);
      safeEmit(state.copyWith(data: DataState.error(MessagedException(error: e))));
      return false;
    }
  }

  /// Собирает новые фото (base64) из выбранных пресет-ассетов и снятых/выбранных
  /// с устройства байтов. Логика байтов сохранена 1:1 из прежнего
  /// `AnimalService.changeAnimalPhotos`: ассеты читаются через rootBundle,
  /// пользовательские фото декодируются и ужимаются до [_maxAnimalImageSize].
  Future<List<AnimalImageInput>> _buildNewImages(List<GalleryItemData> list) async {
    final additional = <AnimalImageInput>[];

    final assets = list.where((e) => e.assetPath != null && e.isChoosed);
    if (assets.isNotEmpty) {
      await Future.wait(
        assets.map((e) async {
          final fileBytes = await rootBundle.load(e.assetPath!);
          final buffer = fileBytes.buffer;
          additional.add(
            AnimalImageInput(
              isPrimary: false,
              name: e.assetPath ?? '',
              image: base64Encode(buffer.asUint8List(fileBytes.offsetInBytes, fileBytes.lengthInBytes)),
            ),
          );
        }),
      );
    }

    // Байты выбранных с устройства фото читаются кроссплатформенно на этапе
    // выбора (GalleryItemData.bytes) — File(path).readAsBytesSync() падал бы на
    // web. Элементы без bytes (старый blob-URL без данных) пропускаем.
    for (final e in list.where((e) => e.bytes != null && e.isChoosed)) {
      var image = image_util.decodeImage(e.bytes!);
      if (image == null) continue;
      if (image.height > _maxAnimalImageSize || image.width > _maxAnimalImageSize) {
        final ratio = _maxAnimalImageSize / max(image.height, image.width);
        image = image_util.copyResize(
          image,
          height: (image.height * ratio).floor(),
          width: (image.width * ratio).floor(),
        );
      }
      additional.add(
        AnimalImageInput(isPrimary: false, name: e.filePath ?? '', image: base64Encode(image_util.encodePng(image))),
      );
    }

    return additional;
  }
}

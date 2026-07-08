import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/gallery_item_data.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/cubit/photo_gallery_state.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/widget/gallery_item_data_x.dart';
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
    emit(state.copyWith(data: const DataState.loading()));
    try {
      final animal = await _animalService.fetchAnimalDetail(id: animalId);
      final items = <GalleryItemData>[
        ...(animal.images?.map<GalleryItemData>((e) => GalleryItemData.fromAnimalImage(e)) ?? []),
        ..._galleryImageSet.map<GalleryItemData>((e) => GalleryItemData(assetPath: e.path)),
      ];
      emit(state.copyWith(data: DataState.content(items)));
    } catch (e) {
      emit(state.copyWith(data: DataState.error(e)));
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
    emit(state.copyWith(data: DataState.content(updated), isSelectorChanged: true));
  }

  /// Добавляет новое фото с камеры или из галереи и помечает его выбранным.
  Future<void> addPhoto(ImageSource source) async {
    final currentList = state.data.valueOrNull;
    if (currentList == null) return;
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile == null) return;
    final updated = List<GalleryItemData>.of(currentList)
      ..insert(0, GalleryItemData(filePath: xFile.path, isChoosed: true));
    emit(state.copyWith(data: DataState.content(updated), isSelectorChanged: true));
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
    emit(state.copyWith(data: const DataState.loading()));
    try {
      await _animalService.changeAnimalPhotos(animalId, list);
      return true;
    } catch (e) {
      emit(state.copyWith(data: DataState.error(e)));
      return false;
    }
  }
}

import 'package:acits_flutter/domain/gallery_item_data.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:equatable/equatable.dart';

/// Состояние экрана выбора фотографий животного.
///
/// Держит состояние загрузки списка изображений ([data]) и флаг того, что
/// пользователь менял выбор ([isSelectorChanged]) — по нему показывается кнопка
/// сохранения.
class PhotoGalleryState extends Equatable {
  const PhotoGalleryState({required this.data, this.isSelectorChanged = false});

  /// Начальное состояние — загрузка списка.
  const PhotoGalleryState.loading()
    : data = const DataState<List<GalleryItemData>>.loading(),
      isSelectorChanged = false;

  /// Состояние загрузки/контента/ошибки списка изображений.
  final DataState<List<GalleryItemData>> data;

  /// Менял ли пользователь выбор изображений с момента открытия экрана.
  final bool isSelectorChanged;

  PhotoGalleryState copyWith({DataState<List<GalleryItemData>>? data, bool? isSelectorChanged}) {
    return PhotoGalleryState(
      data: data ?? this.data,
      isSelectorChanged: isSelectorChanged ?? this.isSelectorChanged,
    );
  }

  @override
  List<Object?> get props => [data, isSelectorChanged];
}

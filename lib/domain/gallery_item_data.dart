import 'package:acits_flutter/export.dart';

class GalleryItemData {
  GalleryItemData({this.network, this.assetPath, this.filePath, this.isChoosed = false})
    : assert(network != null || assetPath != null || filePath != null);

  factory GalleryItemData.fromAnimalImage(AnimalImageRead image) {
    return GalleryItemData(network: image, isChoosed: true);
  }

  final AnimalImageRead? network;
  final String? assetPath;
  final String? filePath;
  final bool isChoosed;

  GalleryItemData copyWith({
    final AnimalImageRead? network,
    final String? assetPath,
    final String? filePath,
    final bool? isChoosed,
  }) => GalleryItemData(
    network: network ?? this.network,
    assetPath: assetPath ?? this.assetPath,
    filePath: filePath ?? this.filePath,
    isChoosed: isChoosed ?? this.isChoosed,
  );
}

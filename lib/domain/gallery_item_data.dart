import 'dart:typed_data';

import 'package:acits_flutter/export.dart';

class GalleryItemData {
  GalleryItemData({this.network, this.assetPath, this.filePath, this.bytes, this.isChoosed = false})
    : assert(network != null || assetPath != null || filePath != null);

  factory GalleryItemData.fromAnimalImage(AnimalImageRead image) {
    return GalleryItemData(network: image, isChoosed: true);
  }

  final AnimalImageRead? network;
  final String? assetPath;

  /// Путь/URL выбранного с устройства файла. На web это blob-URL — рендерится
  /// через `Image.network`, но по нему НЕЛЬЗЯ читать байты (dart:io File не
  /// работает). Для загрузки используем [bytes].
  final String? filePath;

  /// Байты выбранного файла, прочитанные кроссплатформенно через
  /// `XFile.readAsBytes()`. Держим их сразу, чтобы не читать файл с ФС при
  /// сабмите (File.readAsBytesSync падает на web).
  final Uint8List? bytes;

  final bool isChoosed;

  GalleryItemData copyWith({
    final AnimalImageRead? network,
    final String? assetPath,
    final String? filePath,
    final Uint8List? bytes,
    final bool? isChoosed,
  }) => GalleryItemData(
    network: network ?? this.network,
    assetPath: assetPath ?? this.assetPath,
    filePath: filePath ?? this.filePath,
    bytes: bytes ?? this.bytes,
    isChoosed: isChoosed ?? this.isChoosed,
  );
}

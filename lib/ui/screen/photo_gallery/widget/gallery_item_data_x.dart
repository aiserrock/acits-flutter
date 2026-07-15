import 'package:acits_flutter/util/util.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/domain/gallery_item_data.dart';
import 'package:acits_flutter/ui/widget/shimmer_network_image.dart';

/// Целевой размер декодирования миниатюр в 3-колоночной сетке. Декодируем
/// картинки уменьшенными (cacheWidth) — иначе полноразмерные фото с камеры
/// (несколько тысяч px) раздувают RAM и тормозят растеризацию.
const _thumbDecodeWidth = 512;

extension GalleryIyemDataX on GalleryItemData {
  Widget get widget => network != null
      ? ShimmerNetworkImage(
          url: UrlCorsProxy.add(network?.image.medium),
          fit: BoxFit.cover,
          cacheWidth: _thumbDecodeWidth,
        )
      : assetPath != null
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(assetPath!, fit: BoxFit.contain),
        )
      // bytes прочитаны кроссплатформенно (см. GalleryItemData.bytes) — рендерим
      // из памяти, чтобы не зависеть от dart:io File (не работает в web).
      : bytes != null
      ? Image.memory(bytes!, fit: BoxFit.cover, cacheWidth: _thumbDecodeWidth)
      : filePath != null
      ? ShimmerNetworkImage(url: filePath, fit: BoxFit.cover, cacheWidth: _thumbDecodeWidth)
      : const SizedBox();
}

extension ListGalleryItemDataX on List<GalleryItemData> {
  int get countChoosedItems => where((element) => element.isChoosed).length;
}

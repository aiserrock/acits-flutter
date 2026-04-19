import 'dart:io';

import 'package:acits_flutter/util/util.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/domain/gallery_item_data.dart';

extension GalleryIyemDataX on GalleryItemData {
  Widget get widget => network != null
      ? Image.network(UrlCorsProxy.add(network?.image?.medium) ?? '', fit: BoxFit.cover)
      : assetPath != null
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(assetPath!, fit: BoxFit.contain),
        )
      : filePath != null
      ? Image.file(File(filePath!), fit: BoxFit.cover)
      : const SizedBox();
}

extension ListGalleryItemDataX on List<GalleryItemData> {
  int get countChoosedItems => where((element) => element.isChoosed).length;
}

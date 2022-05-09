import 'package:flutter/material.dart';

import 'package:acits_flutter/ui/screen/photo_gallery/photo_gallery_screen.dart';

class PhotoGalleryScreenRoute extends MaterialPageRoute<bool> {
  PhotoGalleryScreenRoute({required int animalId})
      : super(builder: (_) => PhotoGalleryScreen(animalId: animalId));
}

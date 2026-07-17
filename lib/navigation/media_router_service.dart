import 'package:animals/animals.dart' show AnimalSpecies;
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:media/media.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';

/// Реализация навигационного контракта медиа-фичи через go_router и [AppRoutes]
/// приложения. Модуль зависит только от абстракции [MediaRouterService];
/// конкретные пути живут здесь.
///
/// [GoRouter] резолвится из [getIt] лениво (регистрируется рантайм-синглтоном в
/// initDi), как в animals/auth/prescriptions router-сервисах.
@Injectable(as: MediaRouterService)
class MediaRouterServiceImpl implements MediaRouterService {
  const MediaRouterServiceImpl();

  GoRouter get _router => getIt<GoRouter>();

  @override
  Future<bool?> openPhotoGallery(int animalId) => _router.push<bool>(AppRoutes.photoGalleryPath(animalId));

  @override
  void openDocViewer(PdfDocFetcher fetcher, {String? title, String? fileName}) {
    _router.push(
      AppRoutes.docViewer,
      extra: <String, Object?>{'fetcher': fetcher, 'title': title, 'fileName': fileName},
    );
  }

  @override
  Future<AnimalSpecies?> pickSpecies({AnimalSpecies? parent}) =>
      _router.push<AnimalSpecies>(AppRoutes.searchSpec, extra: parent);
}

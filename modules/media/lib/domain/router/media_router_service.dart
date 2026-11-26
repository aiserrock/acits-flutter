import 'package:core/domain.dart';
import 'package:animals/animals.dart' show AnimalSpecies;

import 'package:media/domain/domain.dart' show PdfDocFetcher;

export 'package:media/domain/domain.dart' show PdfDocFetcher;

/// Навигационный контракт медиа-фичи. Реализация (знающая go_router-пути
/// приложения) живёт в корневом навигационном слое и инъектится потребителям —
/// так модуль не зависит ни от go_router, ни от роутов приложения.
///
/// Покрывает открытие медиа-экранов из app-shell / других фич: галерея фото
/// животного, просмотрщик PDF-документа, выбор вида животного.
abstract interface class MediaRouterService implements RouterService {
  /// Открыть галерею выбора фотографий животного [animalId]. Возвращает `true`,
  /// если фото были сохранены (карточку животного нужно перезагрузить).
  Future<bool?> openPhotoGallery(int animalId);

  /// Открыть просмотрщик PDF-документа. [fetcher] грузит байты, [title] — заголовок
  /// экрана, [fileName] — имя файла для «Поделиться»/скачивания.
  void openDocViewer(PdfDocFetcher fetcher, {String? title, String? fileName});

  /// Открыть поиск вида животного (опционально внутри [parent]). Возвращает
  /// выбранный [AnimalSpecies] (или null, если отмена).
  Future<AnimalSpecies?> pickSpecies({AnimalSpecies? parent});
}

import 'package:flutter/foundation.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/document/document_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/util/logger/log.dart';

/// Сервис PDF-карточки животного. PDF — через [DocumentRepository] (модульный
/// `AnimalRepository`). Заметки/комментарии переехали в модуль `personal`
/// (`CommentsService`).
@singleton
class AnimalService {
  AnimalService();

  /// Получить PDF карточки животного как байты (кроссплатформенно, без диска).
  /// Раньше возвращал `File` и был доступен только на mobile; теперь байты идут
  /// прямо в рендерер/шаринг и работают в PWA.
  Future<Uint8List> fetchPdfAnimalCard(int animalId) async {
    Log.debug('Fetch PDF animal card: animalId=$animalId');
    // TODO: extract to DI
    final repo = getIt<DocumentRepository>();
    final bytes = await repo.fetchAnimalDoc(animalId);
    // Диагностика источника PDF (одним сообщением): длина в байтах и первые
    // байты (у валидного PDF — «%PDF» = 37 80 68 70).
    final head = bytes.take(8).toList();
    Log.info('[pdf] animalId=$animalId decoded=${bytes.lengthInBytes}B head=$head');
    return bytes;
  }
}

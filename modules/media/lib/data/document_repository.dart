import 'dart:typed_data';

import 'package:core/domain.dart' show MessagedException;
import 'package:animals/animals.dart';

import 'package:media/util/util.dart';

/// Репозиторий доступа к документам (pdf). Работает через модульный
/// [AnimalRepository] (домен + Result, без chopper): байты PDF идут напрямую в
/// рендерер/шаринг — кроссплатформенно, без строкового round-trip'а.
class DocumentRepository {
  DocumentRepository(this._animalRepository, this._shelterProvider);

  final AnimalRepository _animalRepository;
  final CurrentShelterProvider _shelterProvider;

  /// Карточка животного (PDF-байты).
  Future<Uint8List> fetchAnimalDoc(int animalId) async {
    Log.debug('Fetch animal doc: animalId=$animalId');
    final now = DateTime.now();
    final result = await _animalRepository.getAnimalPdf(
      id: animalId,
      pdfType: 'history',
      from: now,
      to: now,
      shelterId: _shelterProvider.shelterId,
    );
    return result.fold(
      (failure) {
        Log.warning('Fetch animal doc failed: animalId=$animalId, error=$failure');
        throw MessagedException(error: failure.toString());
      },
      (bytes) {
        Log.info('Animal doc fetched: animalId=$animalId (${bytes.lengthInBytes}B)');
        return bytes;
      },
    );
  }
}

import 'package:acits_flutter/service/document/pdf_doc_mixin.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/export.dart';

/// Репозиторий доступа к документам (pdf)
@injectable
class DocumentRepository with PdfDocumentMixin {
  DocumentRepository(
    this._authService,
    this._client,
  );

  final AuthService _authService;
  final Openapi _client;

  /// История редактирования информации о животном
  Future<String> fetchAnimalEditingHistory(
    int animalId,
    DateTime from,
    DateTime to,
  ) async {
    final result = await _client.apiV1AnimalsIdPdfTypePdfGet(
      id: animalId,
      pdfType: 'history-editing',
      from: from,
      to: to,
      xCurrentShelter: _authService.currentShelterId,
    );

    final body = result.body;

    if (body != null) {
      return body;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// История назначений животного
  Future<String> fetchAnimalPrescriptionEditingHistory(
    int animalId,
    DateTime from,
    DateTime to,
  ) async {
    final result = await _client.apiV1AnimalsIdPdfTypePdfGet(
      id: animalId,
      pdfType: 'history-prescriptions',
      from: from,
      to: to,
      xCurrentShelter: _authService.currentShelterId,
    );

    final body = result.body;

    if (body != null) {
      return body;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Карточка животного
  Future<String> fetchAnimalDoc(int animalId) async {
    final result = await _client.apiV1AnimalsIdPdfTypePdfGet(
      id: animalId,
      pdfType: 'history',
      from: DateTime.now(),
      to: DateTime.now(),
      xCurrentShelter: _authService.currentShelterId,
    );

    final body = result.body;

    if (body != null) {
      return body;
    } else {
      throw MessagedException(error: result.error);
    }
  }
}

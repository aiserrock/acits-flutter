import 'dart:typed_data';

import 'package:acits_domain/acits_domain.dart' show Shelter;
import 'package:animals/animals.dart' show AnimalRepository, CurrentShelterProvider;
import 'package:applicants/applicants.dart' show StaffService;
import 'package:injectable/injectable.dart';
import 'package:media/media.dart';
import 'package:prescriptions/prescriptions.dart' show PrescriptionService;

import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/document/doc_exporter/doc_exporter.dart';
import 'package:acits_flutter/service/document/pdfjs_ready/pdfjs_ready.dart';

/// DI-модуль медиа-фичи: собирает [DocumentRepository] модуля (поверх
/// `AnimalRepository` + `CurrentShelterProvider` из модуля animals), мостит
/// платформенные порты модуля (экспорт документа, готовность pdf.js, доступ к
/// приютам) к инфраструктуре приложения и собирает [SearchDeps] для generic-
/// поиска. Зеркалит паттерн prescriptions_register / animals_port_bridges.
@module
abstract class MediaRegister {
  @injectable
  DocumentRepository documentRepository(AnimalRepository repository, CurrentShelterProvider shelterProvider) =>
      DocumentRepository(repository, shelterProvider);

  /// Зависимости generic-поиска, собранные из data-слоя фич. Резолвится в
  /// роутере приложения и передаётся в `Search.byTypeKey` — модуль не тянет getIt.
  @injectable
  SearchDeps searchDeps(
    AnimalRepository animalRepository,
    StaffService staffService,
    PrescriptionService prescriptionService,
    MediaShelterProvider shelterProvider,
  ) => SearchDeps(
    animalRepository: animalRepository,
    staffService: staffService,
    prescriptionService: prescriptionService,
    shelterProvider: shelterProvider,
  );
}

/// Реализация порта экспорта документа [DocExporterPort] поверх платформенного
/// [DocExporter] приложения (io/web conditional import уже внутри него).
@Injectable(as: DocExporterPort)
class AppDocExporter implements DocExporterPort {
  AppDocExporter() : _exporter = DocExporter();

  final DocExporter _exporter;

  @override
  Future<void> share(
    Uint8List bytes, {
    required String fileName,
    String mimeType = 'application/pdf',
    String? text,
    String? subject,
  }) => _exporter.share(bytes, fileName: fileName, mimeType: mimeType, text: text, subject: subject);

  @override
  Future<void> download(Uint8List bytes, {required String fileName, String mimeType = 'application/pdf'}) =>
      _exporter.download(bytes, fileName: fileName, mimeType: mimeType);
}

/// Реализация порта готовности pdf.js [PdfjsReadyPort] поверх платформенного
/// [PdfjsReady] приложения (conditional import web/stub).
@Injectable(as: PdfjsReadyPort)
class AppPdfjsReady implements PdfjsReadyPort {
  const AppPdfjsReady();

  @override
  Future<void> ensure() => PdfjsReady.ensure();
}

/// Текущий приют и список всех приютов из [AuthService] для generic-поиска
/// животных (скоупинг) и приютов (выбор).
@Injectable(as: MediaShelterProvider)
class AuthServiceMediaShelter implements MediaShelterProvider {
  const AuthServiceMediaShelter(this._authService);

  final AuthService _authService;

  @override
  int? get currentShelterId => _authService.currentShelterId;

  @override
  Future<List<Shelter>> getAllShelterList({int limit = 25, int offset = 0, String? searchRequest}) =>
      _authService.getAllShelterList(limit: limit, offset: offset, searchRequest: searchRequest);
}

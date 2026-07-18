import 'dart:io';

import 'package:core/api.dart';
import 'package:injectable/injectable.dart';
import 'package:personal/personal.dart';

import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/file/file_service.dart';

/// DI-модуль фичи «Личный кабинет / комментарии»: собирает [PersonalService]
/// (поверх [ProfileApiPort]) и [CommentsService] (поверх [AnimalNotesApiPort]) и
/// мостит порты модуля к сервисам приложения (приют + разлогин, загрузка файла).
/// Зеркалит паттерн applicants_register.dart / prescriptions_register.dart.
@module
abstract class PersonalRegister {
  @singleton
  PersonalService personalService(ProfileApiPort port, PersonalShelterProvider shelterProvider) =>
      PersonalService(port, shelterProvider);

  @singleton
  CommentsService commentsService(AnimalNotesApiPort port, PersonalShelterProvider shelterProvider) =>
      CommentsService(port, shelterProvider);
}

/// Текущий приют + сигнал разлогина из [AuthService] для скоупинга запросов
/// профиля/заметок и сброса кеша профиля. [AuthService] сам является
/// `ChangeNotifier` и уведомляет при разлогине.
@Injectable(as: PersonalShelterProvider)
class AuthServicePersonalShelter implements PersonalShelterProvider {
  const AuthServicePersonalShelter(this._authService);

  final AuthService _authService;

  @override
  int? get shelterId => _authService.currentShelterId;

  @override
  void addLogoutListener(void Function() listener) => _authService.addListener(listener);

  @override
  void removeLogoutListener(void Function() listener) => _authService.removeListener(listener);
}

/// Загрузка файла вложения комментария на устройство через app [FileService].
@Injectable(as: CommentFileOpener)
class FileServiceCommentFileOpener implements CommentFileOpener {
  const FileServiceCommentFileOpener(this._fileService);

  final FileService _fileService;

  @override
  Future<File> loadFile(String url, String title) => _fileService.loadFile(url, title);
}

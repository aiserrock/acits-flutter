// Доменные исключения переехали в acits_domain (DTO-free, чистые Dart-типы),
// чтобы модули (auth и др.) видели их без зависимости на приложение. Ре-экспорт
// сохраняет существующие импорты `package:acits_flutter/domain/exception.dart`.
export 'package:acits_domain/acits_domain.dart' show NotAuthorizedException, MessagedException, EmailConfirmException;

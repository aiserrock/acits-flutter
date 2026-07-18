// Доменные исключения переехали в core (domain-слой) (DTO-free, чистые Dart-типы),
// чтобы модули (auth и др.) видели их без зависимости на приложение. Ре-экспорт
// сохраняет существующие импорты `package:acits_flutter/domain/exception.dart`.
export 'package:core/domain.dart' show NotAuthorizedException, MessagedException, EmailConfirmException;

/// Data-слой модуля. Наружу отдаются реализация репозитория (для DI) и тонкая
/// сервис-обёртка для generic-поиска media. Мапперы принимают DTO в
/// конструкторах и остаются внутренними — так DTO не проникают в публичный
/// barrel модуля.
library;

export 'repository/repository.dart';
export 'staff_service.dart';

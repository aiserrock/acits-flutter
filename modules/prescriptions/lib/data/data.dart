/// Data-слой модуля. Наружу отдаются реализация репозитория (для DI) и тонкая
/// сервис-обёртка для generic-поиска media. DTO остаются внутри реализации —
/// в публичный barrel модуля они не проникают.
library;

export 'prescription_service.dart';
export 'repository/repository.dart';

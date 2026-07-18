// Фасад [Log] переехал в пакет `app_services` (app-композиция; собственная копия
// Talker-фасада, как у каждого feature-модуля свой util/log.dart — вне общего
// `util`-барреля, чтобы не ловить неоднозначный импорт `Log` в модулях). Ре-
// экспорт сохраняет существующие импорты `package:acits_flutter/util/logger/log.dart`.
export 'package:app_services/app_services.dart' show Log;

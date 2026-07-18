import 'package:dio/dio.dart';

/// Заглушки-места под будущие интерцепторы. Реальные реализации (проверка
/// сети, dev-логирование) появятся позже — сейчас это объявленные швы, чтобы
/// зафиксировать порядок в фабрике.

/// Проверка соединения перед запросом. Placeholder — пропускает как есть.
class ConnectivityInterceptor extends Interceptor {}

/// Dev-логирование. Placeholder. ВАЖНО: не вешать логирование тела на upload —
/// многомегабайтные картинки заморозят изолят.
class LoggingInterceptor extends Interceptor {}

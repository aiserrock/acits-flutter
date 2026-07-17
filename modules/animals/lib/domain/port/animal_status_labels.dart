import '../animal_status.dart';

/// Человекочитаемые названия статусов. Названия приходят из серверного конфига
/// (ConfigService в приложении), поэтому модуль получает их через порт, а не
/// хардкодит — корень мостит к `ConfigService.getStatus131Name`.
abstract interface class AnimalStatusLabels {
  /// Локализованное название статуса [status] (или null, если не задано).
  String? label(AnimalStatus status);
}

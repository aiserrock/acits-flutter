import 'package:prescriptions/domain/domain.dart';

/// Порт загрузки животного для экрана редактора назначения.
///
/// Экрану нужна лёгкая ссылка [PrescriptionAnimalRef] (id/имя/миниатюра) при
/// создании назначения из карточки (preset-животное по id) и в режиме правки.
/// Реализация в приложении читает богатую сущность через `AnimalRepository`
/// (модуль animals) — так модуль назначений не связывается с модулем животных
/// напрямую (порт вместо module→module зависимости).
abstract interface class PrescriptionAnimalLoader {
  /// Загрузить лёгкую ссылку на животное по id (или null, если не найдено).
  Future<PrescriptionAnimalRef?> loadById(int animalId);
}

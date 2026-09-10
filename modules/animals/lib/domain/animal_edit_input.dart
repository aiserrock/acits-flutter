import 'package:equatable/equatable.dart';

/// Доменные входные данные для create/update — DTO-free форма того, что
/// собирает экран редактирования. Репозиторий разворачивает это в write-DTO.

/// Значение атрибута животного при записи (несёт attrId/isRequired, которых нет
/// в плоской карте [Animal.attributes]).
class AnimalAttributeInput extends Equatable {
  const AnimalAttributeInput({required this.attrId, required this.name, required this.value, this.isRequired = false});

  final int attrId;
  final String name;
  final String value;
  final bool isRequired;

  @override
  List<Object?> get props => [attrId, name, value, isRequired];
}

/// Новое фото для загрузки (base64).
class AnimalImageInput extends Equatable {
  const AnimalImageInput({required this.name, required this.image, this.isPrimary});

  final String name;

  /// Base64-пейлоад изображения.
  final String image;
  final bool? isPrimary;

  @override
  List<Object?> get props => [name, image, isPrimary];
}

import 'package:equatable/equatable.dart';

/// Вид/порода из справочника (для выбора при редактировании животного).
/// Минимальный доменный тип: id/имя/уровень таксономии + родитель.
class AnimalSpecies extends Equatable {
  const AnimalSpecies({
    required this.id,
    required this.name,
    required this.level,
    this.parentId,
    this.parentName,
    this.categoryName,
  });

  final int id;
  final String name;

  /// Уровень в дереве таксономии (1/2/3).
  final int level;
  final int? parentId;
  final String? parentName;
  final String? categoryName;

  @override
  List<Object?> get props => [id, name, level, parentId, parentName, categoryName];
}

import 'package:equatable/equatable.dart';

import 'package:animals/domain/domain.dart';

/// Лёгкая сущность для строки списка: ровно то, что рисует карточка списка
/// (имя, id, вид «семейство, вид», статус, дата поступления, превью-фото).
/// Легче полного [Animal] — без атрибутов/куратора/заявителя/документов.
class AnimalListItem extends Equatable {
  const AnimalListItem({
    required this.id,
    required this.name,
    required this.status,
    this.thumbUrl,
    this.speciesParentName,
    this.speciesName,
    this.dateJoined,
  });

  final int id;
  final String name;
  final AnimalStatus status;
  final String? thumbUrl;

  /// Семейство вида (напр. «Кошки») — первая часть строки вида в карточке.
  final String? speciesParentName;

  /// Вид (напр. «Кошка домашняя») — вторая часть строки вида в карточке.
  final String? speciesName;

  /// Дата поступления в приют (строка «Поступил: …» в карточке).
  final DateTime? dateJoined;

  @override
  List<Object?> get props => [id, name, status, thumbUrl, speciesParentName, speciesName, dateJoined];
}

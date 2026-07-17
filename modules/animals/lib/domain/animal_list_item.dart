import 'package:equatable/equatable.dart';

import 'animal_status.dart';

/// Лёгкая сущность для строки списка: ровно то, что рисует карточка списка.
class AnimalListItem extends Equatable {
  const AnimalListItem({required this.id, required this.name, required this.status, this.thumbUrl, this.speciesName});

  final int id;
  final String name;
  final AnimalStatus status;
  final String? thumbUrl;
  final String? speciesName;

  @override
  List<Object?> get props => [id, name, status, thumbUrl, speciesName];
}

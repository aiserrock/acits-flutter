import 'package:equatable/equatable.dart';

class Prescription extends Equatable {
  const Prescription({
    required this.id,
    required this.animalId,
    required this.typeCode,
    this.title,
    this.startDate,
    this.endDate,
  });

  final int id;
  final int animalId;
  final String typeCode;
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  List<Object?> get props => [id, animalId, typeCode, title, startDate, endDate];
}

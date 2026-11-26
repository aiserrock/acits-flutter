import 'package:prescriptions/domain/domain.dart';

/// Компактное назначение внутри исполнения «на сегодня» (главный экран).
///
/// В отличие от [Prescription] несёт вложенное [AnimalShort] (а не голый id).
class PrescriptionShortEntity {
  const PrescriptionShortEntity({
    required this.animal,
    required this.drugs,
    this.id,
    this.type = PrescriptionType.unknown,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.extraTypeAttributes,
  });

  final int? id;
  final PrescriptionType type;
  final String? description;
  final AnimalShort animal;
  final List<PrescriptionDrug> drugs;
  final String? createdBy;
  final String? updatedBy;
  final Map<String, dynamic>? extraTypeAttributes;
}

/// Исполнение назначения, запланированное «на сегодня» (лента главного экрана).
class PrescriptionExecutionToday {
  const PrescriptionExecutionToday({required this.prescription, required this.executeAt, this.id});

  final int? id;
  final PrescriptionShortEntity prescription;
  final DateTime executeAt;
}

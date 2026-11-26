import 'package:prescriptions/domain/domain.dart';

/// Доменная модель назначения (рецепта).
///
/// Плоская сущность поверх полиморфного (`oneOf` по `my_type`) серверного
/// назначения: все подтипы имеют идентичный набор полей и различаются лишь
/// [type] и [extraTypeAttributes]. Не зависит от `gen/api` — маппинг DTO→сущность
/// живёт в реализации [PrescriptionRepository] (data-слой).
class Prescription {
  const Prescription({
    required this.animal,
    required this.type,
    required this.drugs,
    required this.executions,
    this.id,
    this.url,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.files,
    this.extraTypeAttributes,
  });

  final int? id;
  final String? url;

  /// ID животного назначения.
  final int animal;
  final PrescriptionType type;
  final PrescriptionDuration? duration;
  final String? description;
  final String? createdBy;
  final String? updatedBy;
  final List<PrescriptionDrug> drugs;
  final List<PrescriptionExecution> executions;
  final List<PrescriptionFile>? files;

  /// Специфичные для типа назначения атрибуты (структура зависит от [type]).
  final Map<String, dynamic>? extraTypeAttributes;

  Prescription copyWith({
    int? id,
    String? url,
    int? animal,
    PrescriptionType? type,
    PrescriptionDuration? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
    Map<String, dynamic>? extraTypeAttributes,
  }) {
    return Prescription(
      id: id ?? this.id,
      url: url ?? this.url,
      animal: animal ?? this.animal,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      drugs: drugs ?? this.drugs,
      executions: executions ?? this.executions,
      files: files ?? this.files,
      extraTypeAttributes: extraTypeAttributes ?? this.extraTypeAttributes,
    );
  }
}

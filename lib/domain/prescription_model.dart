import 'package:acits_flutter/gen/api/openapi.swagger.dart';

/// Доменная модель назначения (рецепта).
///
/// На бэкенде `Prescription` — полиморфный тип (oneOf из 9 подтипов по
/// `my_type`), который `swagger_dart_code_generator` НЕ умеет и генерит как
/// пустой класс без полей. Поэтому используем собственную плоскую модель с
/// ручной (де)сериализацией: все 9 подтипов имеют идентичный набор полей и
/// различаются лишь `my_type` и `extra_type_attributes`.
///
/// Модель совместима и со «сломанной» схемой (component_name=extra_attribures),
/// и с пофикшенной — данные в JSON одинаковы, парсинг идёт по факту полей.
class PrescriptionModel {
  const PrescriptionModel({
    required this.animal,
    required this.myType,
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
  final int animal;
  final PrescriptionShortMyTypeEnum myType;
  final DurationEnum? duration;
  final String? description;
  final String? createdBy;
  final String? updatedBy;
  final List<PrescriptionDrug> drugs;
  final List<PrescriptionExecution> executions;
  final List<PrescriptionFile>? files;

  /// Специфичные для типа назначения атрибуты (структура зависит от `myType`).
  final Map<String, dynamic>? extraTypeAttributes;

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      animal: (json['animal'] as num).toInt(),
      myType: prescriptionShortMyTypeEnumFromJson(json['my_type']),
      duration: durationEnumNullableFromJson(json['duration']),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs: (json['drugs'] as List<dynamic>? ?? [])
          .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList(),
      executions: (json['executions'] as List<dynamic>? ?? [])
          .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      extraTypeAttributes: json['extra_type_attributes'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      'animal': animal,
      'my_type': prescriptionShortMyTypeEnumToJson(myType),
      if (duration != null) 'duration': durationEnumToJson(duration!),
      if (description != null) 'description': description,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      'drugs': drugs.map((e) => e.toJson()).toList(),
      'executions': executions.map((e) => e.toJson()).toList(),
      if (files != null) 'files': files!.map((e) => e.toJson()).toList(),
      if (extraTypeAttributes != null) 'extra_type_attributes': extraTypeAttributes,
    };
  }

  static List<PrescriptionModel> listFromJson(dynamic results) {
    if (results is! List) return const [];
    return results.whereType<Map<String, dynamic>>().map(PrescriptionModel.fromJson).toList();
  }

  PrescriptionModel copyWith({
    int? id,
    String? url,
    int? animal,
    PrescriptionShortMyTypeEnum? myType,
    DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
    Map<String, dynamic>? extraTypeAttributes,
  }) {
    return PrescriptionModel(
      id: id ?? this.id,
      url: url ?? this.url,
      animal: animal ?? this.animal,
      myType: myType ?? this.myType,
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

/// Страница списка назначений (пагинация DRF) для доменной модели.
///
/// Аналог сгенерённого `PaginatedPrescriptionList`, но с рабочими элементами
/// [PrescriptionModel] вместо пустых `Prescription`.
class PrescriptionListPage {
  const PrescriptionListPage({this.count, this.next, this.previous, this.results = const []});

  final int? count;
  final String? next;
  final String? previous;
  final List<PrescriptionModel> results;

  factory PrescriptionListPage.fromJson(Map<String, dynamic> json) {
    return PrescriptionListPage(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: PrescriptionModel.listFromJson(json['results']),
    );
  }

  PrescriptionListPage copyWith({List<PrescriptionModel>? results}) {
    return PrescriptionListPage(
      count: count,
      next: next,
      previous: previous,
      results: results ?? this.results,
    );
  }
}

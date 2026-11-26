// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisPrescription _$AnalysisPrescriptionFromJson(
  Map<String, dynamic> json,
) => AnalysisPrescription(
  id: AnalysisPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: AnalysisPrescription._read_animal(json['animal']),
  myType: AnalysisPrescription._read_myType(json['my_type']),
  duration: AnalysisPrescription._read_duration(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      AnalysisPrescription._extras(json, 'additionalProperties') == null
      ? const {}
      : AnalysisPrescription._readExtras(
          AnalysisPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$AnalysisPrescriptionToJson(
  AnalysisPrescription instance,
) => <String, dynamic>{
  'id': ?AnalysisPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?AnalysisPrescription._write_animal(instance.animal),
  'my_type': ?AnalysisPrescription._write_myType(instance.myType),
  'duration': ?AnalysisPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

AppointmentPrescription _$AppointmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => AppointmentPrescription(
  id: AppointmentPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: AppointmentPrescription._read_animal(json['animal']),
  myType: AppointmentPrescription._read_myType(json['my_type']),
  duration: AppointmentPrescription._read_duration(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      AppointmentPrescription._extras(json, 'additionalProperties') == null
      ? const {}
      : AppointmentPrescription._readExtras(
          AppointmentPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$AppointmentPrescriptionToJson(
  AppointmentPrescription instance,
) => <String, dynamic>{
  'id': ?AppointmentPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?AppointmentPrescription._write_animal(instance.animal),
  'my_type': ?AppointmentPrescription._write_myType(instance.myType),
  'duration': ?AppointmentPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

CourseOfTreatmentPrescription _$CourseOfTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => CourseOfTreatmentPrescription(
  id: CourseOfTreatmentPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: CourseOfTreatmentPrescription._read_animal(json['animal']),
  myType: CourseOfTreatmentPrescription._read_myType(json['my_type']),
  duration: CourseOfTreatmentPrescription._read_duration(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      CourseOfTreatmentPrescription._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : CourseOfTreatmentPrescription._readExtras(
          CourseOfTreatmentPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$CourseOfTreatmentPrescriptionToJson(
  CourseOfTreatmentPrescription instance,
) => <String, dynamic>{
  'id': ?CourseOfTreatmentPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?CourseOfTreatmentPrescription._write_animal(instance.animal),
  'my_type': ?CourseOfTreatmentPrescription._write_myType(instance.myType),
  'duration': ?CourseOfTreatmentPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

OtherPrescription _$OtherPrescriptionFromJson(Map<String, dynamic> json) =>
    OtherPrescription(
      id: OtherPrescription._read_id(json['id']),
      url: json['url'] as String?,
      animal: OtherPrescription._read_animal(json['animal']),
      myType: OtherPrescription._read_myType(json['my_type']),
      duration: OtherPrescription._read_duration(json['duration']),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      drugs: (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList(),
      executions: (json['executions'] as List<dynamic>?)
          ?.map(
            (e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalProperties:
          OtherPrescription._extras(json, 'additionalProperties') == null
          ? const {}
          : OtherPrescription._readExtras(
              OtherPrescription._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$OtherPrescriptionToJson(OtherPrescription instance) =>
    <String, dynamic>{
      'id': ?OtherPrescription._write_id(instance.id),
      'url': ?instance.url,
      'animal': ?OtherPrescription._write_animal(instance.animal),
      'my_type': ?OtherPrescription._write_myType(instance.myType),
      'duration': ?OtherPrescription._write_duration(instance.duration),
      'description': ?instance.description,
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
      'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
      'files': ?instance.files?.map((e) => e.toJson()).toList(),
    };

ReadmissionPrescription _$ReadmissionPrescriptionFromJson(
  Map<String, dynamic> json,
) => ReadmissionPrescription(
  id: ReadmissionPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: ReadmissionPrescription._read_animal(json['animal']),
  myType: ReadmissionPrescription._read_myType(json['my_type']),
  duration: ReadmissionPrescription._read_duration(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      ReadmissionPrescription._extras(json, 'additionalProperties') == null
      ? const {}
      : ReadmissionPrescription._readExtras(
          ReadmissionPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$ReadmissionPrescriptionToJson(
  ReadmissionPrescription instance,
) => <String, dynamic>{
  'id': ?ReadmissionPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?ReadmissionPrescription._write_animal(instance.animal),
  'my_type': ?ReadmissionPrescription._write_myType(instance.myType),
  'duration': ?ReadmissionPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

RemovingStitchesPrescription _$RemovingStitchesPrescriptionFromJson(
  Map<String, dynamic> json,
) => RemovingStitchesPrescription(
  id: RemovingStitchesPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: RemovingStitchesPrescription._read_animal(json['animal']),
  myType: RemovingStitchesPrescription._read_myType(json['my_type']),
  duration: RemovingStitchesPrescription._read_duration(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      RemovingStitchesPrescription._extras(json, 'additionalProperties') == null
      ? const {}
      : RemovingStitchesPrescription._readExtras(
          RemovingStitchesPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$RemovingStitchesPrescriptionToJson(
  RemovingStitchesPrescription instance,
) => <String, dynamic>{
  'id': ?RemovingStitchesPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?RemovingStitchesPrescription._write_animal(instance.animal),
  'my_type': ?RemovingStitchesPrescription._write_myType(instance.myType),
  'duration': ?RemovingStitchesPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

WoundHealingPrescription _$WoundHealingPrescriptionFromJson(
  Map<String, dynamic> json,
) => WoundHealingPrescription(
  id: WoundHealingPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: WoundHealingPrescription._read_animal(json['animal']),
  myType: WoundHealingPrescription._read_myType(json['my_type']),
  duration: WoundHealingPrescription._read_duration(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      WoundHealingPrescription._extras(json, 'additionalProperties') == null
      ? const {}
      : WoundHealingPrescription._readExtras(
          WoundHealingPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$WoundHealingPrescriptionToJson(
  WoundHealingPrescription instance,
) => <String, dynamic>{
  'id': ?WoundHealingPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?WoundHealingPrescription._write_animal(instance.animal),
  'my_type': ?WoundHealingPrescription._write_myType(instance.myType),
  'duration': ?WoundHealingPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

ParasitesTreatmentPrescription _$ParasitesTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) {
  $checkKeys(json, disallowNullValues: const ['extra_type_attributes']);
  return ParasitesTreatmentPrescription(
    id: ParasitesTreatmentPrescription._read_id(json['id']),
    url: json['url'] as String?,
    animal: ParasitesTreatmentPrescription._read_animal(json['animal']),
    myType: ParasitesTreatmentPrescription._read_myType(json['my_type']),
    extraTypeAttributes: json['extra_type_attributes'] == null
        ? null
        : ParasitesPrescriptionExtraAttr.fromJson(
            json['extra_type_attributes'] as Map<String, dynamic>,
          ),
    duration: ParasitesTreatmentPrescription._read_duration(json['duration']),
    description: json['description'] as String?,
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    drugs: (json['drugs'] as List<dynamic>?)
        ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
        .toList(),
    executions: (json['executions'] as List<dynamic>?)
        ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
        .toList(),
    files: (json['files'] as List<dynamic>?)
        ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
        .toList(),
    additionalProperties:
        ParasitesTreatmentPrescription._extras(json, 'additionalProperties') ==
            null
        ? const {}
        : ParasitesTreatmentPrescription._readExtras(
            ParasitesTreatmentPrescription._extras(
              json,
              'additionalProperties',
            ),
          ),
  );
}

Map<String, dynamic> _$ParasitesTreatmentPrescriptionToJson(
  ParasitesTreatmentPrescription instance,
) => <String, dynamic>{
  'id': ?ParasitesTreatmentPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?ParasitesTreatmentPrescription._write_animal(instance.animal),
  'my_type': ?ParasitesTreatmentPrescription._write_myType(instance.myType),
  'extra_type_attributes': ?instance.extraTypeAttributes?.toJson(),
  'duration': ?ParasitesTreatmentPrescription._write_duration(
    instance.duration,
  ),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

VaccinationPrescription _$VaccinationPrescriptionFromJson(
  Map<String, dynamic> json,
) => VaccinationPrescription(
  id: VaccinationPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: VaccinationPrescription._read_animal(json['animal']),
  myType: VaccinationPrescription._read_myType(json['my_type']),
  duration: VaccinationPrescription._read_duration(json['duration']),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      VaccinationPrescription._extras(json, 'additionalProperties') == null
      ? const {}
      : VaccinationPrescription._readExtras(
          VaccinationPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$VaccinationPrescriptionToJson(
  VaccinationPrescription instance,
) => <String, dynamic>{
  'id': ?VaccinationPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?VaccinationPrescription._write_animal(instance.animal),
  'my_type': ?VaccinationPrescription._write_myType(instance.myType),
  'duration': ?VaccinationPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

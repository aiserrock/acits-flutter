// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchedAnalysisPrescription _$PatchedAnalysisPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedAnalysisPrescription(
  id: PatchedAnalysisPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: PatchedAnalysisPrescription._read_animal(json['animal']),
  myType: PatchedAnalysisPrescription._read_myType(json['my_type']),
  duration: PatchedAnalysisPrescription._read_duration(json['duration']),
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
      PatchedAnalysisPrescription._extras(json, 'additionalProperties') == null
      ? const {}
      : PatchedAnalysisPrescription._readExtras(
          PatchedAnalysisPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PatchedAnalysisPrescriptionToJson(
  PatchedAnalysisPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedAnalysisPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedAnalysisPrescription._write_animal(instance.animal),
  'my_type': ?PatchedAnalysisPrescription._write_myType(instance.myType),
  'duration': ?PatchedAnalysisPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

PatchedAppointmentPrescription _$PatchedAppointmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedAppointmentPrescription(
  id: PatchedAppointmentPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: PatchedAppointmentPrescription._read_animal(json['animal']),
  myType: PatchedAppointmentPrescription._read_myType(json['my_type']),
  duration: PatchedAppointmentPrescription._read_duration(json['duration']),
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
      PatchedAppointmentPrescription._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : PatchedAppointmentPrescription._readExtras(
          PatchedAppointmentPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PatchedAppointmentPrescriptionToJson(
  PatchedAppointmentPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedAppointmentPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedAppointmentPrescription._write_animal(instance.animal),
  'my_type': ?PatchedAppointmentPrescription._write_myType(instance.myType),
  'duration': ?PatchedAppointmentPrescription._write_duration(
    instance.duration,
  ),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

PatchedCourseOfTreatmentPrescription
_$PatchedCourseOfTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedCourseOfTreatmentPrescription(
  id: PatchedCourseOfTreatmentPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: PatchedCourseOfTreatmentPrescription._read_animal(json['animal']),
  myType: PatchedCourseOfTreatmentPrescription._read_myType(json['my_type']),
  duration: PatchedCourseOfTreatmentPrescription._read_duration(
    json['duration'],
  ),
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
      PatchedCourseOfTreatmentPrescription._extras(
            json,
            'additionalProperties',
          ) ==
          null
      ? const {}
      : PatchedCourseOfTreatmentPrescription._readExtras(
          PatchedCourseOfTreatmentPrescription._extras(
            json,
            'additionalProperties',
          ),
        ),
);

Map<String, dynamic> _$PatchedCourseOfTreatmentPrescriptionToJson(
  PatchedCourseOfTreatmentPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedCourseOfTreatmentPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedCourseOfTreatmentPrescription._write_animal(
    instance.animal,
  ),
  'my_type': ?PatchedCourseOfTreatmentPrescription._write_myType(
    instance.myType,
  ),
  'duration': ?PatchedCourseOfTreatmentPrescription._write_duration(
    instance.duration,
  ),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

PatchedOtherPrescription _$PatchedOtherPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedOtherPrescription(
  id: PatchedOtherPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: PatchedOtherPrescription._read_animal(json['animal']),
  myType: PatchedOtherPrescription._read_myType(json['my_type']),
  duration: PatchedOtherPrescription._read_duration(json['duration']),
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
      PatchedOtherPrescription._extras(json, 'additionalProperties') == null
      ? const {}
      : PatchedOtherPrescription._readExtras(
          PatchedOtherPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PatchedOtherPrescriptionToJson(
  PatchedOtherPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedOtherPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedOtherPrescription._write_animal(instance.animal),
  'my_type': ?PatchedOtherPrescription._write_myType(instance.myType),
  'duration': ?PatchedOtherPrescription._write_duration(instance.duration),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

PatchedParasitesTreatmentPrescription
_$PatchedParasitesTreatmentPrescriptionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['extra_type_attributes']);
  return PatchedParasitesTreatmentPrescription(
    id: PatchedParasitesTreatmentPrescription._read_id(json['id']),
    url: json['url'] as String?,
    animal: PatchedParasitesTreatmentPrescription._read_animal(json['animal']),
    myType: PatchedParasitesTreatmentPrescription._read_myType(json['my_type']),
    extraTypeAttributes: json['extra_type_attributes'] == null
        ? null
        : ParasitesPrescriptionExtraAttr.fromJson(
            json['extra_type_attributes'] as Map<String, dynamic>,
          ),
    duration: PatchedParasitesTreatmentPrescription._read_duration(
      json['duration'],
    ),
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
        PatchedParasitesTreatmentPrescription._extras(
              json,
              'additionalProperties',
            ) ==
            null
        ? const {}
        : PatchedParasitesTreatmentPrescription._readExtras(
            PatchedParasitesTreatmentPrescription._extras(
              json,
              'additionalProperties',
            ),
          ),
  );
}

Map<String, dynamic> _$PatchedParasitesTreatmentPrescriptionToJson(
  PatchedParasitesTreatmentPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedParasitesTreatmentPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedParasitesTreatmentPrescription._write_animal(
    instance.animal,
  ),
  'my_type': ?PatchedParasitesTreatmentPrescription._write_myType(
    instance.myType,
  ),
  'extra_type_attributes': ?instance.extraTypeAttributes?.toJson(),
  'duration': ?PatchedParasitesTreatmentPrescription._write_duration(
    instance.duration,
  ),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

PatchedReadmissionPrescription _$PatchedReadmissionPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedReadmissionPrescription(
  id: PatchedReadmissionPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: PatchedReadmissionPrescription._read_animal(json['animal']),
  myType: PatchedReadmissionPrescription._read_myType(json['my_type']),
  duration: PatchedReadmissionPrescription._read_duration(json['duration']),
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
      PatchedReadmissionPrescription._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : PatchedReadmissionPrescription._readExtras(
          PatchedReadmissionPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PatchedReadmissionPrescriptionToJson(
  PatchedReadmissionPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedReadmissionPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedReadmissionPrescription._write_animal(instance.animal),
  'my_type': ?PatchedReadmissionPrescription._write_myType(instance.myType),
  'duration': ?PatchedReadmissionPrescription._write_duration(
    instance.duration,
  ),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

PatchedRemovingStitchesPrescription
_$PatchedRemovingStitchesPrescriptionFromJson(Map<String, dynamic> json) =>
    PatchedRemovingStitchesPrescription(
      id: PatchedRemovingStitchesPrescription._read_id(json['id']),
      url: json['url'] as String?,
      animal: PatchedRemovingStitchesPrescription._read_animal(json['animal']),
      myType: PatchedRemovingStitchesPrescription._read_myType(json['my_type']),
      duration: PatchedRemovingStitchesPrescription._read_duration(
        json['duration'],
      ),
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
          PatchedRemovingStitchesPrescription._extras(
                json,
                'additionalProperties',
              ) ==
              null
          ? const {}
          : PatchedRemovingStitchesPrescription._readExtras(
              PatchedRemovingStitchesPrescription._extras(
                json,
                'additionalProperties',
              ),
            ),
    );

Map<String, dynamic> _$PatchedRemovingStitchesPrescriptionToJson(
  PatchedRemovingStitchesPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedRemovingStitchesPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedRemovingStitchesPrescription._write_animal(instance.animal),
  'my_type': ?PatchedRemovingStitchesPrescription._write_myType(
    instance.myType,
  ),
  'duration': ?PatchedRemovingStitchesPrescription._write_duration(
    instance.duration,
  ),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

PatchedWoundHealingPrescription _$PatchedWoundHealingPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedWoundHealingPrescription(
  id: PatchedWoundHealingPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: PatchedWoundHealingPrescription._read_animal(json['animal']),
  myType: PatchedWoundHealingPrescription._read_myType(json['my_type']),
  duration: PatchedWoundHealingPrescription._read_duration(json['duration']),
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
      PatchedWoundHealingPrescription._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : PatchedWoundHealingPrescription._readExtras(
          PatchedWoundHealingPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PatchedWoundHealingPrescriptionToJson(
  PatchedWoundHealingPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedWoundHealingPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedWoundHealingPrescription._write_animal(instance.animal),
  'my_type': ?PatchedWoundHealingPrescription._write_myType(instance.myType),
  'duration': ?PatchedWoundHealingPrescription._write_duration(
    instance.duration,
  ),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

PatchedVaccinationPrescription _$PatchedVaccinationPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedVaccinationPrescription(
  id: PatchedVaccinationPrescription._read_id(json['id']),
  url: json['url'] as String?,
  animal: PatchedVaccinationPrescription._read_animal(json['animal']),
  myType: PatchedVaccinationPrescription._read_myType(json['my_type']),
  duration: PatchedVaccinationPrescription._read_duration(json['duration']),
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
      PatchedVaccinationPrescription._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : PatchedVaccinationPrescription._readExtras(
          PatchedVaccinationPrescription._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PatchedVaccinationPrescriptionToJson(
  PatchedVaccinationPrescription instance,
) => <String, dynamic>{
  'id': ?PatchedVaccinationPrescription._write_id(instance.id),
  'url': ?instance.url,
  'animal': ?PatchedVaccinationPrescription._write_animal(instance.animal),
  'my_type': ?PatchedVaccinationPrescription._write_myType(instance.myType),
  'duration': ?PatchedVaccinationPrescription._write_duration(
    instance.duration,
  ),
  'description': ?instance.description,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'drugs': ?instance.drugs?.map((e) => e.toJson()).toList(),
  'executions': ?instance.executions?.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
};

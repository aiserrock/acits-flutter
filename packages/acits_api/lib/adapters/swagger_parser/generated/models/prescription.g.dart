// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{};

PrescriptionCourseOfTreatmentPrescription
_$PrescriptionCourseOfTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => PrescriptionCourseOfTreatmentPrescription(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  animal: (json['animal'] as num).toInt(),
  myType: CourseOfTreatmentPrescriptionMyTypeEnum.fromJson(
    json['myType'] as String,
  ),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  drugs: (json['drugs'] as List<dynamic>)
      .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>)
      .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PrescriptionCourseOfTreatmentPrescriptionToJson(
  PrescriptionCourseOfTreatmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

PrescriptionAppointmentPrescription
_$PrescriptionAppointmentPrescriptionFromJson(Map<String, dynamic> json) =>
    PrescriptionAppointmentPrescription(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      animal: (json['animal'] as num).toInt(),
      myType: AppointmentPrescriptionMyTypeEnum.fromJson(
        json['myType'] as String,
      ),
      duration: json['duration'] == null
          ? null
          : DurationEnum.fromJson(json['duration'] as String),
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      drugs: (json['drugs'] as List<dynamic>)
          .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList(),
      executions: (json['executions'] as List<dynamic>)
          .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrescriptionAppointmentPrescriptionToJson(
  PrescriptionAppointmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

PrescriptionReadmissionPrescription
_$PrescriptionReadmissionPrescriptionFromJson(Map<String, dynamic> json) =>
    PrescriptionReadmissionPrescription(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      animal: (json['animal'] as num).toInt(),
      myType: ReadmissionPrescriptionMyTypeEnum.fromJson(
        json['myType'] as String,
      ),
      duration: json['duration'] == null
          ? null
          : DurationEnum.fromJson(json['duration'] as String),
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      drugs: (json['drugs'] as List<dynamic>)
          .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList(),
      executions: (json['executions'] as List<dynamic>)
          .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrescriptionReadmissionPrescriptionToJson(
  PrescriptionReadmissionPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

PrescriptionRemovingStitchesPrescription
_$PrescriptionRemovingStitchesPrescriptionFromJson(Map<String, dynamic> json) =>
    PrescriptionRemovingStitchesPrescription(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      animal: (json['animal'] as num).toInt(),
      myType: RemovingStitchesPrescriptionMyTypeEnum.fromJson(
        json['myType'] as String,
      ),
      duration: json['duration'] == null
          ? null
          : DurationEnum.fromJson(json['duration'] as String),
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      drugs: (json['drugs'] as List<dynamic>)
          .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList(),
      executions: (json['executions'] as List<dynamic>)
          .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrescriptionRemovingStitchesPrescriptionToJson(
  PrescriptionRemovingStitchesPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

PrescriptionWoundHealingPrescription
_$PrescriptionWoundHealingPrescriptionFromJson(Map<String, dynamic> json) =>
    PrescriptionWoundHealingPrescription(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      animal: (json['animal'] as num).toInt(),
      myType: WoundHealingPrescriptionMyTypeEnum.fromJson(
        json['myType'] as String,
      ),
      duration: json['duration'] == null
          ? null
          : DurationEnum.fromJson(json['duration'] as String),
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      drugs: (json['drugs'] as List<dynamic>)
          .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList(),
      executions: (json['executions'] as List<dynamic>)
          .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrescriptionWoundHealingPrescriptionToJson(
  PrescriptionWoundHealingPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

PrescriptionAnalysisPrescription _$PrescriptionAnalysisPrescriptionFromJson(
  Map<String, dynamic> json,
) => PrescriptionAnalysisPrescription(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  animal: (json['animal'] as num).toInt(),
  myType: AnalysisPrescriptionMyTypeEnum.fromJson(json['myType'] as String),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  drugs: (json['drugs'] as List<dynamic>)
      .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>)
      .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PrescriptionAnalysisPrescriptionToJson(
  PrescriptionAnalysisPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

PrescriptionParasitesTreatmentPrescription
_$PrescriptionParasitesTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => PrescriptionParasitesTreatmentPrescription(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  animal: (json['animal'] as num).toInt(),
  myType: ParasitesTreatmentPrescriptionMyTypeEnum.fromJson(
    json['myType'] as String,
  ),
  extraTypeAttributes: ParasitesPrescriptionExtraAttr.fromJson(
    json['extraTypeAttributes'] as Map<String, dynamic>,
  ),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  drugs: (json['drugs'] as List<dynamic>)
      .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>)
      .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PrescriptionParasitesTreatmentPrescriptionToJson(
  PrescriptionParasitesTreatmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'extraTypeAttributes': instance.extraTypeAttributes,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

PrescriptionVaccinationPrescription
_$PrescriptionVaccinationPrescriptionFromJson(Map<String, dynamic> json) =>
    PrescriptionVaccinationPrescription(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      animal: (json['animal'] as num).toInt(),
      myType: VaccinationPrescriptionMyTypeEnum.fromJson(
        json['myType'] as String,
      ),
      duration: json['duration'] == null
          ? null
          : DurationEnum.fromJson(json['duration'] as String),
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      drugs: (json['drugs'] as List<dynamic>)
          .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
          .toList(),
      executions: (json['executions'] as List<dynamic>)
          .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrescriptionVaccinationPrescriptionToJson(
  PrescriptionVaccinationPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

PrescriptionOtherPrescription _$PrescriptionOtherPrescriptionFromJson(
  Map<String, dynamic> json,
) => PrescriptionOtherPrescription(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  animal: (json['animal'] as num).toInt(),
  myType: OtherPrescriptionMyTypeEnum.fromJson(json['myType'] as String),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  drugs: (json['drugs'] as List<dynamic>)
      .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>)
      .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PrescriptionOtherPrescriptionToJson(
  PrescriptionOtherPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'myType': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};

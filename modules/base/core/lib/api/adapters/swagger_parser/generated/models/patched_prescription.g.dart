// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patched_prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PatchedPrescriptionToJson(
  PatchedPrescription instance,
) => <String, dynamic>{};

PatchedPrescriptionPatchedCourseOfTreatmentPrescription
_$PatchedPrescriptionPatchedCourseOfTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedCourseOfTreatmentPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : CourseOfTreatmentPrescriptionMyTypeEnum.fromJson(
          json['myType'] as String,
        ),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic>
_$PatchedPrescriptionPatchedCourseOfTreatmentPrescriptionToJson(
  PatchedPrescriptionPatchedCourseOfTreatmentPrescription instance,
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

PatchedPrescriptionPatchedAppointmentPrescription
_$PatchedPrescriptionPatchedAppointmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedAppointmentPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : AppointmentPrescriptionMyTypeEnum.fromJson(json['myType'] as String),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PatchedPrescriptionPatchedAppointmentPrescriptionToJson(
  PatchedPrescriptionPatchedAppointmentPrescription instance,
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

PatchedPrescriptionPatchedReadmissionPrescription
_$PatchedPrescriptionPatchedReadmissionPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedReadmissionPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : ReadmissionPrescriptionMyTypeEnum.fromJson(json['myType'] as String),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PatchedPrescriptionPatchedReadmissionPrescriptionToJson(
  PatchedPrescriptionPatchedReadmissionPrescription instance,
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

PatchedPrescriptionPatchedRemovingStitchesPrescription
_$PatchedPrescriptionPatchedRemovingStitchesPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedRemovingStitchesPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : RemovingStitchesPrescriptionMyTypeEnum.fromJson(
          json['myType'] as String,
        ),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic>
_$PatchedPrescriptionPatchedRemovingStitchesPrescriptionToJson(
  PatchedPrescriptionPatchedRemovingStitchesPrescription instance,
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

PatchedPrescriptionPatchedWoundHealingPrescription
_$PatchedPrescriptionPatchedWoundHealingPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedWoundHealingPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : WoundHealingPrescriptionMyTypeEnum.fromJson(json['myType'] as String),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PatchedPrescriptionPatchedWoundHealingPrescriptionToJson(
  PatchedPrescriptionPatchedWoundHealingPrescription instance,
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

PatchedPrescriptionPatchedAnalysisPrescription
_$PatchedPrescriptionPatchedAnalysisPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedAnalysisPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : AnalysisPrescriptionMyTypeEnum.fromJson(json['myType'] as String),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PatchedPrescriptionPatchedAnalysisPrescriptionToJson(
  PatchedPrescriptionPatchedAnalysisPrescription instance,
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

PatchedPrescriptionPatchedParasitesTreatmentPrescription
_$PatchedPrescriptionPatchedParasitesTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedParasitesTreatmentPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : ParasitesTreatmentPrescriptionMyTypeEnum.fromJson(
          json['myType'] as String,
        ),
  extraTypeAttributes: json['extraTypeAttributes'] == null
      ? null
      : ParasitesPrescriptionExtraAttr.fromJson(
          json['extraTypeAttributes'] as Map<String, dynamic>,
        ),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic>
_$PatchedPrescriptionPatchedParasitesTreatmentPrescriptionToJson(
  PatchedPrescriptionPatchedParasitesTreatmentPrescription instance,
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

PatchedPrescriptionPatchedVaccinationPrescription
_$PatchedPrescriptionPatchedVaccinationPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedVaccinationPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : VaccinationPrescriptionMyTypeEnum.fromJson(json['myType'] as String),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PatchedPrescriptionPatchedVaccinationPrescriptionToJson(
  PatchedPrescriptionPatchedVaccinationPrescription instance,
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

PatchedPrescriptionPatchedOtherPrescription
_$PatchedPrescriptionPatchedOtherPrescriptionFromJson(
  Map<String, dynamic> json,
) => PatchedPrescriptionPatchedOtherPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['myType'] == null
      ? null
      : OtherPrescriptionMyTypeEnum.fromJson(json['myType'] as String),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
  updatedBy: json['updatedBy'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PatchedPrescriptionPatchedOtherPrescriptionToJson(
  PatchedPrescriptionPatchedOtherPrescription instance,
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

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'analysis_prescription.dart';
import 'analysis_prescription_my_type_enum.dart';
import 'appointment_prescription.dart';
import 'appointment_prescription_my_type_enum.dart';
import 'course_of_treatment_prescription.dart';
import 'course_of_treatment_prescription_my_type_enum.dart';
import 'duration_enum.dart';
import 'other_prescription.dart';
import 'other_prescription_my_type_enum.dart';
import 'parasites_prescription_extra_attr.dart';
import 'parasites_treatment_prescription.dart';
import 'parasites_treatment_prescription_my_type_enum.dart';
import 'prescription_drug.dart';
import 'prescription_execution.dart';
import 'prescription_file.dart';
import 'readmission_prescription.dart';
import 'readmission_prescription_my_type_enum.dart';
import 'removing_stitches_prescription.dart';
import 'removing_stitches_prescription_my_type_enum.dart';
import 'vaccination_prescription.dart';
import 'vaccination_prescription_my_type_enum.dart';
import 'wound_healing_prescription.dart';
import 'wound_healing_prescription_my_type_enum.dart';


part 'prescription.g.dart';

@JsonSerializable(createFactory: false)
sealed class Prescription {
  const Prescription();
  
  factory Prescription.fromJson(Map<String, dynamic> json) =>
      PrescriptionSealedDeserializer.tryDeserialize(json);
  
  Map<String, dynamic> toJson();
}

extension PrescriptionSealedDeserializer on Prescription {
  static Prescription tryDeserialize(
    Map<String, dynamic> json, {
    String key = 'my_type',
    Map<Type, Object?>? mapping,
  }) {
    final mappingFallback = const <Type, Object?>{
      PrescriptionCourseOfTreatmentPrescription: 'COURSE_OF_TREATMENT',
      PrescriptionAppointmentPrescription: 'APPOINTMENT',
      PrescriptionReadmissionPrescription: 'READMISSION',
      PrescriptionRemovingStitchesPrescription: 'REMOVING_STITCHES',
      PrescriptionWoundHealingPrescription: 'WOUND_HEALING',
      PrescriptionAnalysisPrescription: 'ANALYSIS',
      PrescriptionParasitesTreatmentPrescription: 'PARASITES_TREATMENT',
      PrescriptionVaccinationPrescription: 'VACCINATION',
      PrescriptionOtherPrescription: 'OTHER',
    };
    final value = json[key];
    final effective = mapping ?? mappingFallback;
    return switch (value) {
      _ when value == effective[PrescriptionCourseOfTreatmentPrescription] => PrescriptionCourseOfTreatmentPrescription.fromJson(json),
      _ when value == effective[PrescriptionAppointmentPrescription] => PrescriptionAppointmentPrescription.fromJson(json),
      _ when value == effective[PrescriptionReadmissionPrescription] => PrescriptionReadmissionPrescription.fromJson(json),
      _ when value == effective[PrescriptionRemovingStitchesPrescription] => PrescriptionRemovingStitchesPrescription.fromJson(json),
      _ when value == effective[PrescriptionWoundHealingPrescription] => PrescriptionWoundHealingPrescription.fromJson(json),
      _ when value == effective[PrescriptionAnalysisPrescription] => PrescriptionAnalysisPrescription.fromJson(json),
      _ when value == effective[PrescriptionParasitesTreatmentPrescription] => PrescriptionParasitesTreatmentPrescription.fromJson(json),
      _ when value == effective[PrescriptionVaccinationPrescription] => PrescriptionVaccinationPrescription.fromJson(json),
      _ when value == effective[PrescriptionOtherPrescription] => PrescriptionOtherPrescription.fromJson(json),
      _ => throw FormatException('Unknown discriminator value "${json[key]}" for Prescription'),
    };
  }
}

@JsonSerializable()
class PrescriptionCourseOfTreatmentPrescription extends Prescription implements CourseOfTreatmentPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final CourseOfTreatmentPrescriptionMyTypeEnum? myType;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionCourseOfTreatmentPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionCourseOfTreatmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionCourseOfTreatmentPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionCourseOfTreatmentPrescriptionToJson(this);
}
@JsonSerializable()
class PrescriptionAppointmentPrescription extends Prescription implements AppointmentPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final AppointmentPrescriptionMyTypeEnum? myType;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionAppointmentPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionAppointmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionAppointmentPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionAppointmentPrescriptionToJson(this);
}
@JsonSerializable()
class PrescriptionReadmissionPrescription extends Prescription implements ReadmissionPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final ReadmissionPrescriptionMyTypeEnum? myType;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionReadmissionPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionReadmissionPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionReadmissionPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionReadmissionPrescriptionToJson(this);
}
@JsonSerializable()
class PrescriptionRemovingStitchesPrescription extends Prescription implements RemovingStitchesPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final RemovingStitchesPrescriptionMyTypeEnum? myType;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionRemovingStitchesPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionRemovingStitchesPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionRemovingStitchesPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionRemovingStitchesPrescriptionToJson(this);
}
@JsonSerializable()
class PrescriptionWoundHealingPrescription extends Prescription implements WoundHealingPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final WoundHealingPrescriptionMyTypeEnum? myType;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionWoundHealingPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionWoundHealingPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionWoundHealingPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionWoundHealingPrescriptionToJson(this);
}
@JsonSerializable()
class PrescriptionAnalysisPrescription extends Prescription implements AnalysisPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final AnalysisPrescriptionMyTypeEnum? myType;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionAnalysisPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionAnalysisPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionAnalysisPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionAnalysisPrescriptionToJson(this);
}
@JsonSerializable()
class PrescriptionParasitesTreatmentPrescription extends Prescription implements ParasitesTreatmentPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final ParasitesTreatmentPrescriptionMyTypeEnum? myType;
  @override
  final ParasitesPrescriptionExtraAttr? extraTypeAttributes;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionParasitesTreatmentPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.extraTypeAttributes,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionParasitesTreatmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionParasitesTreatmentPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionParasitesTreatmentPrescriptionToJson(this);
}
@JsonSerializable()
class PrescriptionVaccinationPrescription extends Prescription implements VaccinationPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final VaccinationPrescriptionMyTypeEnum? myType;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionVaccinationPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionVaccinationPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionVaccinationPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionVaccinationPrescriptionToJson(this);
}
@JsonSerializable()
class PrescriptionOtherPrescription extends Prescription implements OtherPrescription {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? animal;
  @override
  final OtherPrescriptionMyTypeEnum? myType;
  @override
  final DurationEnum? duration;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final List<PrescriptionDrug>? drugs;
  @override
  final List<PrescriptionExecution>? executions;
  @override
  final List<PrescriptionFile>? files;

  const PrescriptionOtherPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.duration,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    required this.files,
  });
  
  factory PrescriptionOtherPrescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionOtherPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PrescriptionOtherPrescriptionToJson(this);
}

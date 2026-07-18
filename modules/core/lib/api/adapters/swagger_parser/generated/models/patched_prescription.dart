// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'analysis_prescription_my_type_enum.dart';
import 'appointment_prescription_my_type_enum.dart';
import 'course_of_treatment_prescription_my_type_enum.dart';
import 'duration_enum.dart';
import 'other_prescription_my_type_enum.dart';
import 'parasites_prescription_extra_attr.dart';
import 'parasites_treatment_prescription_my_type_enum.dart';
import 'patched_analysis_prescription.dart';
import 'patched_appointment_prescription.dart';
import 'patched_course_of_treatment_prescription.dart';
import 'patched_other_prescription.dart';
import 'patched_parasites_treatment_prescription.dart';
import 'patched_readmission_prescription.dart';
import 'patched_removing_stitches_prescription.dart';
import 'patched_vaccination_prescription.dart';
import 'patched_wound_healing_prescription.dart';
import 'prescription_drug.dart';
import 'prescription_execution.dart';
import 'prescription_file.dart';
import 'readmission_prescription_my_type_enum.dart';
import 'removing_stitches_prescription_my_type_enum.dart';
import 'vaccination_prescription_my_type_enum.dart';
import 'wound_healing_prescription_my_type_enum.dart';


part 'patched_prescription.g.dart';

@JsonSerializable(createFactory: false)
sealed class PatchedPrescription {
  const PatchedPrescription();
  
  factory PatchedPrescription.fromJson(Map<String, dynamic> json) =>
      PatchedPrescriptionSealedDeserializer.tryDeserialize(json);
  
  Map<String, dynamic> toJson();
}

extension PatchedPrescriptionSealedDeserializer on PatchedPrescription {
  static PatchedPrescription tryDeserialize(
    Map<String, dynamic> json, {
    String key = 'my_type',
    Map<Type, Object?>? mapping,
  }) {
    final mappingFallback = const <Type, Object?>{
      PatchedPrescriptionPatchedCourseOfTreatmentPrescription: 'COURSE_OF_TREATMENT',
      PatchedPrescriptionPatchedAppointmentPrescription: 'APPOINTMENT',
      PatchedPrescriptionPatchedReadmissionPrescription: 'READMISSION',
      PatchedPrescriptionPatchedRemovingStitchesPrescription: 'REMOVING_STITCHES',
      PatchedPrescriptionPatchedWoundHealingPrescription: 'WOUND_HEALING',
      PatchedPrescriptionPatchedAnalysisPrescription: 'ANALYSIS',
      PatchedPrescriptionPatchedParasitesTreatmentPrescription: 'PARASITES_TREATMENT',
      PatchedPrescriptionPatchedVaccinationPrescription: 'VACCINATION',
      PatchedPrescriptionPatchedOtherPrescription: 'OTHER',
    };
    final value = json[key];
    final effective = mapping ?? mappingFallback;
    return switch (value) {
      _ when value == effective[PatchedPrescriptionPatchedCourseOfTreatmentPrescription] => PatchedPrescriptionPatchedCourseOfTreatmentPrescription.fromJson(json),
      _ when value == effective[PatchedPrescriptionPatchedAppointmentPrescription] => PatchedPrescriptionPatchedAppointmentPrescription.fromJson(json),
      _ when value == effective[PatchedPrescriptionPatchedReadmissionPrescription] => PatchedPrescriptionPatchedReadmissionPrescription.fromJson(json),
      _ when value == effective[PatchedPrescriptionPatchedRemovingStitchesPrescription] => PatchedPrescriptionPatchedRemovingStitchesPrescription.fromJson(json),
      _ when value == effective[PatchedPrescriptionPatchedWoundHealingPrescription] => PatchedPrescriptionPatchedWoundHealingPrescription.fromJson(json),
      _ when value == effective[PatchedPrescriptionPatchedAnalysisPrescription] => PatchedPrescriptionPatchedAnalysisPrescription.fromJson(json),
      _ when value == effective[PatchedPrescriptionPatchedParasitesTreatmentPrescription] => PatchedPrescriptionPatchedParasitesTreatmentPrescription.fromJson(json),
      _ when value == effective[PatchedPrescriptionPatchedVaccinationPrescription] => PatchedPrescriptionPatchedVaccinationPrescription.fromJson(json),
      _ when value == effective[PatchedPrescriptionPatchedOtherPrescription] => PatchedPrescriptionPatchedOtherPrescription.fromJson(json),
      _ => throw FormatException('Unknown discriminator value "${json[key]}" for PatchedPrescription'),
    };
  }
}

@JsonSerializable()
class PatchedPrescriptionPatchedCourseOfTreatmentPrescription extends PatchedPrescription implements PatchedCourseOfTreatmentPrescription {
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

  const PatchedPrescriptionPatchedCourseOfTreatmentPrescription({
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
  
  factory PatchedPrescriptionPatchedCourseOfTreatmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedCourseOfTreatmentPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedCourseOfTreatmentPrescriptionToJson(this);
}
@JsonSerializable()
class PatchedPrescriptionPatchedAppointmentPrescription extends PatchedPrescription implements PatchedAppointmentPrescription {
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

  const PatchedPrescriptionPatchedAppointmentPrescription({
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
  
  factory PatchedPrescriptionPatchedAppointmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedAppointmentPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedAppointmentPrescriptionToJson(this);
}
@JsonSerializable()
class PatchedPrescriptionPatchedReadmissionPrescription extends PatchedPrescription implements PatchedReadmissionPrescription {
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

  const PatchedPrescriptionPatchedReadmissionPrescription({
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
  
  factory PatchedPrescriptionPatchedReadmissionPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedReadmissionPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedReadmissionPrescriptionToJson(this);
}
@JsonSerializable()
class PatchedPrescriptionPatchedRemovingStitchesPrescription extends PatchedPrescription implements PatchedRemovingStitchesPrescription {
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

  const PatchedPrescriptionPatchedRemovingStitchesPrescription({
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
  
  factory PatchedPrescriptionPatchedRemovingStitchesPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedRemovingStitchesPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedRemovingStitchesPrescriptionToJson(this);
}
@JsonSerializable()
class PatchedPrescriptionPatchedWoundHealingPrescription extends PatchedPrescription implements PatchedWoundHealingPrescription {
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

  const PatchedPrescriptionPatchedWoundHealingPrescription({
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
  
  factory PatchedPrescriptionPatchedWoundHealingPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedWoundHealingPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedWoundHealingPrescriptionToJson(this);
}
@JsonSerializable()
class PatchedPrescriptionPatchedAnalysisPrescription extends PatchedPrescription implements PatchedAnalysisPrescription {
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

  const PatchedPrescriptionPatchedAnalysisPrescription({
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
  
  factory PatchedPrescriptionPatchedAnalysisPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedAnalysisPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedAnalysisPrescriptionToJson(this);
}
@JsonSerializable()
class PatchedPrescriptionPatchedParasitesTreatmentPrescription extends PatchedPrescription implements PatchedParasitesTreatmentPrescription {
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

  const PatchedPrescriptionPatchedParasitesTreatmentPrescription({
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
  
  factory PatchedPrescriptionPatchedParasitesTreatmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedParasitesTreatmentPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedParasitesTreatmentPrescriptionToJson(this);
}
@JsonSerializable()
class PatchedPrescriptionPatchedVaccinationPrescription extends PatchedPrescription implements PatchedVaccinationPrescription {
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

  const PatchedPrescriptionPatchedVaccinationPrescription({
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
  
  factory PatchedPrescriptionPatchedVaccinationPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedVaccinationPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedVaccinationPrescriptionToJson(this);
}
@JsonSerializable()
class PatchedPrescriptionPatchedOtherPrescription extends PatchedPrescription implements PatchedOtherPrescription {
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

  const PatchedPrescriptionPatchedOtherPrescription({
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
  
  factory PatchedPrescriptionPatchedOtherPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionPatchedOtherPrescriptionFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$PatchedPrescriptionPatchedOtherPrescriptionToJson(this);
}

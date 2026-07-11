// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum AnalysisPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ANALYSIS')
  analysis('ANALYSIS');

  final String? value;

  const AnalysisPrescriptionMyTypeEnum(this.value);
}

enum AppointmentPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('APPOINTMENT')
  appointment('APPOINTMENT');

  final String? value;

  const AppointmentPrescriptionMyTypeEnum(this.value);
}

enum CourseOfTreatmentPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('COURSE_OF_TREATMENT')
  courseOfTreatment('COURSE_OF_TREATMENT');

  final String? value;

  const CourseOfTreatmentPrescriptionMyTypeEnum(this.value);
}

enum DurationEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('EVERYDAY')
  everyday('EVERYDAY'),
  @JsonValue('EVERY_WEEK')
  everyWeek('EVERY_WEEK'),
  @JsonValue('CUSTOM')
  custom('CUSTOM');

  final String? value;

  const DurationEnum(this.value);
}

enum LevelEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue(1)
  value_1(1),
  @JsonValue(2)
  value_2(2),
  @JsonValue(3)
  value_3(3);

  final int? value;

  const LevelEnum(this.value);
}

enum OtherPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('OTHER')
  other('OTHER');

  final String? value;

  const OtherPrescriptionMyTypeEnum(this.value);
}

enum ParasitesTreatmentPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PARASITES_TREATMENT')
  parasitesTreatment('PARASITES_TREATMENT');

  final String? value;

  const ParasitesTreatmentPrescriptionMyTypeEnum(this.value);
}

enum ParasitesTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ENDOPARASITES')
  endoparasites('ENDOPARASITES'),
  @JsonValue('ECTOPARASITES')
  ectoparasites('ECTOPARASITES');

  final String? value;

  const ParasitesTypeEnum(this.value);
}

enum PrescriptionExecutionStatusEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('IN_PROGRESS')
  inProgress('IN_PROGRESS'),
  @JsonValue('DONE')
  done('DONE'),
  @JsonValue('EXPIRED')
  expired('EXPIRED'),
  @JsonValue('CANCELLED')
  cancelled('CANCELLED');

  final String? value;

  const PrescriptionExecutionStatusEnum(this.value);
}

enum PrescriptionShortMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('COURSE_OF_TREATMENT')
  courseOfTreatment('COURSE_OF_TREATMENT'),
  @JsonValue('APPOINTMENT')
  appointment('APPOINTMENT'),
  @JsonValue('READMISSION')
  readmission('READMISSION'),
  @JsonValue('REMOVING_STITCHES')
  removingStitches('REMOVING_STITCHES'),
  @JsonValue('WOUND_HEALING')
  woundHealing('WOUND_HEALING'),
  @JsonValue('ANALYSIS')
  analysis('ANALYSIS'),
  @JsonValue('PARASITES_TREATMENT')
  parasitesTreatment('PARASITES_TREATMENT'),
  @JsonValue('VACCINATION')
  vaccination('VACCINATION'),
  @JsonValue('OTHER')
  other('OTHER');

  final String? value;

  const PrescriptionShortMyTypeEnum(this.value);
}

enum ReadmissionPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('READMISSION')
  readmission('READMISSION');

  final String? value;

  const ReadmissionPrescriptionMyTypeEnum(this.value);
}

enum RemovingStitchesPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('REMOVING_STITCHES')
  removingStitches('REMOVING_STITCHES');

  final String? value;

  const RemovingStitchesPrescriptionMyTypeEnum(this.value);
}

enum RoleEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('GUEST')
  guest('GUEST'),
  @JsonValue('WORKER')
  worker('WORKER');

  final String? value;

  const RoleEnum(this.value);
}

enum Status69fEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('IN_THE_SHELTER')
  inTheShelter('IN_THE_SHELTER'),
  @JsonValue('HOSPITAL')
  hospital('HOSPITAL'),
  @JsonValue('OVEREXPOSURE')
  overexposure('OVEREXPOSURE'),
  @JsonValue('ATTACHED')
  attached('ATTACHED'),
  @JsonValue('PREPARING_TO_RELEASE')
  preparingToRelease('PREPARING_TO_RELEASE'),
  @JsonValue('RELEASED')
  released('RELEASED'),
  @JsonValue('DEATH')
  death('DEATH'),
  @JsonValue('EUTHANASIA')
  euthanasia('EUTHANASIA'),
  @JsonValue('IN_CLINIC')
  inClinic('IN_CLINIC');

  final String? value;

  const Status69fEnum(this.value);
}

enum VaccinationPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('VACCINATION')
  vaccination('VACCINATION');

  final String? value;

  const VaccinationPrescriptionMyTypeEnum(this.value);
}

enum WoundHealingPrescriptionMyTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('WOUND_HEALING')
  woundHealing('WOUND_HEALING');

  final String? value;

  const WoundHealingPrescriptionMyTypeEnum(this.value);
}

enum ApiSchemaGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('json')
  json('json'),
  @JsonValue('yaml')
  yaml('yaml');

  final String? value;

  const ApiSchemaGetFormat(this.value);
}

enum ApiSchemaGetLang {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('en')
  en('en'),
  @JsonValue('ru')
  ru('ru');

  final String? value;

  const ApiSchemaGetLang(this.value);
}

enum ApiV1AnimalsIdHistoryGetCreatedAtRange {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('month')
  month('month'),
  @JsonValue('today')
  today('today'),
  @JsonValue('week')
  week('week'),
  @JsonValue('year')
  year('year'),
  @JsonValue('yesterday')
  yesterday('yesterday');

  final String? value;

  const ApiV1AnimalsIdHistoryGetCreatedAtRange(this.value);
}

enum ApiV1AnimalsSpeciesGetLevel {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue(1)
  value_1(1),
  @JsonValue(2)
  value_2(2),
  @JsonValue(3)
  value_3(3);

  final int? value;

  const ApiV1AnimalsSpeciesGetLevel(this.value);
}

enum ApiV1AnimalsStatsGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('json')
  json('json'),
  @JsonValue('pdf')
  pdf('pdf'),
  @JsonValue('xlsx')
  xlsx('xlsx');

  final String? value;

  const ApiV1AnimalsStatsGetFormat(this.value);
}

import 'package:json_annotation/json_annotation.dart';

enum DurationEnum {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('EVERYDAY')
  everyday,
  @JsonValue('EVERY_WEEK')
  everyWeek,
  @JsonValue('CUSTOM')
  custom,
}

const $DurationEnumMap = {
  DurationEnum.everyday: 'EVERYDAY',
  DurationEnum.everyWeek: 'EVERY_WEEK',
  DurationEnum.custom: 'CUSTOM',
};

enum LevelEnum {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('1')
  value_1,
  @JsonValue('2')
  value_2,
  @JsonValue('3')
  value_3,
}

const $LevelEnumMap = {LevelEnum.value_1: '1', LevelEnum.value_2: '2', LevelEnum.value_3: '3'};

enum MyTypeEnum {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('COURSE_OF_TREATMENT')
  courseOfTreatment,
  @JsonValue('APPOINTMENT')
  appointment,
  @JsonValue('READMISSION')
  readmission,
  @JsonValue('REMOVING_STITCHES')
  removingStitches,
  @JsonValue('WOUND_HEALING')
  woundHealing,
  @JsonValue('ANALYSIS')
  analysis,
}

const $MyTypeEnumMap = {
  MyTypeEnum.courseOfTreatment: 'COURSE_OF_TREATMENT',
  MyTypeEnum.appointment: 'APPOINTMENT',
  MyTypeEnum.readmission: 'READMISSION',
  MyTypeEnum.removingStitches: 'REMOVING_STITCHES',
  MyTypeEnum.woundHealing: 'WOUND_HEALING',
  MyTypeEnum.analysis: 'ANALYSIS',
};

enum PrescriptionExecutionStatusEnum {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('IN_PROGRESS')
  inProgress,
  @JsonValue('DONE')
  done,
  @JsonValue('EXPIRED')
  expired,
  @JsonValue('CANCELLED')
  cancelled,
}

const $PrescriptionExecutionStatusEnumMap = {
  PrescriptionExecutionStatusEnum.inProgress: 'IN_PROGRESS',
  PrescriptionExecutionStatusEnum.done: 'DONE',
  PrescriptionExecutionStatusEnum.expired: 'EXPIRED',
  PrescriptionExecutionStatusEnum.cancelled: 'CANCELLED',
};

enum RoleEnum {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('GUEST')
  guest,
  @JsonValue('WORKER')
  worker,
}

const $RoleEnumMap = {RoleEnum.guest: 'GUEST', RoleEnum.worker: 'WORKER'};

enum Status131Enum {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('IN_THE_SHELTER')
  inTheShelter,
  @JsonValue('HOSPITAL')
  hospital,
  @JsonValue('OVEREXPOSURE')
  overexposure,
  @JsonValue('ATTACHED')
  attached,
  @JsonValue('PREPARING_TO_RELEASE')
  preparingToRelease,
  @JsonValue('RELEASED')
  released,
  @JsonValue('DEATH')
  death,
  @JsonValue('EUTHANASIA')
  euthanasia,
}

const $Status131EnumMap = {
  Status131Enum.inTheShelter: 'IN_THE_SHELTER',
  Status131Enum.hospital: 'HOSPITAL',
  Status131Enum.overexposure: 'OVEREXPOSURE',
  Status131Enum.attached: 'ATTACHED',
  Status131Enum.preparingToRelease: 'PREPARING_TO_RELEASE',
  Status131Enum.released: 'RELEASED',
  Status131Enum.death: 'DEATH',
  Status131Enum.euthanasia: 'EUTHANASIA',
};

enum ApiSchemaGetFormat {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('json')
  json,
  @JsonValue('yaml')
  yaml,
}

const $ApiSchemaGetFormatMap = {ApiSchemaGetFormat.json: 'json', ApiSchemaGetFormat.yaml: 'yaml'};

enum ApiSchemaGetLang {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('en')
  en,
  @JsonValue('ru')
  ru,
}

const $ApiSchemaGetLangMap = {ApiSchemaGetLang.en: 'en', ApiSchemaGetLang.ru: 'ru'};

enum ApiV1AnimalsIdHistoryGetCreatedAtRange {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('month')
  month,
  @JsonValue('today')
  today,
  @JsonValue('week')
  week,
  @JsonValue('year')
  year,
  @JsonValue('yesterday')
  yesterday,
}

const $ApiV1AnimalsIdHistoryGetCreatedAtRangeMap = {
  ApiV1AnimalsIdHistoryGetCreatedAtRange.month: 'month',
  ApiV1AnimalsIdHistoryGetCreatedAtRange.today: 'today',
  ApiV1AnimalsIdHistoryGetCreatedAtRange.week: 'week',
  ApiV1AnimalsIdHistoryGetCreatedAtRange.year: 'year',
  ApiV1AnimalsIdHistoryGetCreatedAtRange.yesterday: 'yesterday',
};

enum ApiV1AnimalsSpeciesGetLevel {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('1')
  value_1,
  @JsonValue('2')
  value_2,
  @JsonValue('3')
  value_3,
}

const $ApiV1AnimalsSpeciesGetLevelMap = {
  ApiV1AnimalsSpeciesGetLevel.value_1: '1',
  ApiV1AnimalsSpeciesGetLevel.value_2: '2',
  ApiV1AnimalsSpeciesGetLevel.value_3: '3',
};

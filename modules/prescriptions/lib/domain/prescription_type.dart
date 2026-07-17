/// Тип назначения (доменный enum).
///
/// Зеркалит серверный `PrescriptionShortMyTypeEnum` по wire-значениям, но не
/// зависит от `gen/api`. [unknown] — для неизвестных/отсутствующих типов
/// (толерантный разбор), в UI-табах отфильтровывается (см. [selectable]).
enum PrescriptionType {
  courseOfTreatment('COURSE_OF_TREATMENT'),
  appointment('APPOINTMENT'),
  readmission('READMISSION'),
  removingStitches('REMOVING_STITCHES'),
  woundHealing('WOUND_HEALING'),
  analysis('ANALYSIS'),
  parasitesTreatment('PARASITES_TREATMENT'),
  vaccination('VACCINATION'),
  other('OTHER'),
  unknown(null);

  const PrescriptionType(this.wire);

  /// Серверное строковое значение (`my_type`), либо null для [unknown].
  final String? wire;

  /// Разбор из wire-строки; неизвестное/null → [unknown].
  static PrescriptionType fromWire(String? wire) {
    if (wire == null) return PrescriptionType.unknown;
    for (final type in values) {
      if (type.wire == wire) return type;
    }
    return PrescriptionType.unknown;
  }

  /// Типы, доступные для выбора на экране (без служебного [unknown]) — в том же
  /// порядке, что и вкладки редактора.
  static List<PrescriptionType> get selectable => values.where((t) => t != PrescriptionType.unknown).toList();

  /// Нужны ли лекарства для данного типа назначения.
  bool get hasDrugs =>
      this == PrescriptionType.courseOfTreatment ||
      this == PrescriptionType.removingStitches ||
      this == PrescriptionType.woundHealing;

  /// Можно ли установить несколько дат для данного типа назначения.
  bool get allowMultiDate => this == PrescriptionType.courseOfTreatment;

  /// Можно ли установить несколько времён для данного типа назначения.
  bool get allowMultiTime => this == PrescriptionType.courseOfTreatment;
}

/// Те же флаги, но безопасные для nullable-типа (форма/сабмит держат
/// `PrescriptionType?`). null трактуется как «нет» — как и прежняя логика на
/// nullable-enum.
extension PrescriptionTypeNullableX on PrescriptionType? {
  bool get hasDrugs => this?.hasDrugs ?? false;

  bool get allowMultiDate => this?.allowMultiDate ?? false;

  bool get allowMultiTime => this?.allowMultiTime ?? false;
}

/// Периодичность назначения (доменный enum). Зеркалит серверный `DurationEnum`.
enum PrescriptionDuration {
  everyday('EVERYDAY'),
  everyWeek('EVERY_WEEK'),
  custom('CUSTOM'),
  unknown(null);

  const PrescriptionDuration(this.wire);

  final String? wire;

  static PrescriptionDuration fromWire(String? wire) {
    if (wire == null) return PrescriptionDuration.unknown;
    for (final d in values) {
      if (d.wire == wire) return d;
    }
    return PrescriptionDuration.unknown;
  }
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

/// * `COURSE_OF_TREATMENT` - Course of treatment.
/// * `APPOINTMENT` - Appointment.
/// * `READMISSION` - Readmission.
/// * `REMOVING_STITCHES` - Removing stitches.
/// * `WOUND_HEALING` - Wound healing.
/// * `ANALYSIS` - Analysis.
/// * `PARASITES_TREATMENT` - Parasites Treatment.
/// * `VACCINATION` - Vaccination.
/// * `OTHER` - Other.
@JsonEnum()
enum PrescriptionShortMyTypeEnum {
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
  other('OTHER'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const PrescriptionShortMyTypeEnum(this.json);

  factory PrescriptionShortMyTypeEnum.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<PrescriptionShortMyTypeEnum> get $valuesDefined => values.where((value) => value != $unknown).toList();
}

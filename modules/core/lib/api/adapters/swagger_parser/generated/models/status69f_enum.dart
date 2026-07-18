// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

/// * `IN_THE_SHELTER` - In the shelter.
/// * `HOSPITAL` - Hospital.
/// * `OVEREXPOSURE` - Overexposure.
/// * `ATTACHED` - Attached.
/// * `PREPARING_TO_RELEASE` - Preparing to release.
/// * `RELEASED` - Released.
/// * `DEATH` - Death.
/// * `EUTHANASIA` - Euthanasia.
/// * `IN_CLINIC` - In clinic.
@JsonEnum()
enum Status69fEnum {
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
  inClinic('IN_CLINIC'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const Status69fEnum(this.json);

  factory Status69fEnum.fromJson(String json) => values.firstWhere(
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
  static List<Status69fEnum> get $valuesDefined => values.where((value) => value != $unknown).toList();
}

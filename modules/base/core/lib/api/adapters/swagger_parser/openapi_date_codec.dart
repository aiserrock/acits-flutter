/// Codec for OpenAPI `type: string, format: date` fields, wired into the
/// generator through `generation.type_mappings` in `swagger_parser.yaml`.
///
/// swagger_parser 2.x maps `format: date` to a plain `String`, while 1.x (and
/// the app's DTOs) used `DateTime`. These functions reproduce what
/// json_serializable did for a `DateTime` field in 1.x — `DateTime.parse` on
/// read, `toIso8601String` on write — so values and the request wire format
/// stay identical.
library;

/// Decodes a `date` string (`2024-02-29`, or a full ISO-8601 timestamp).
DateTime openapiDateFromJson(String value) => DateTime.parse(value);

/// Encodes a [DateTime] the way json_serializable did in 1.x.
String openapiDateToJson(DateTime value) => value.toIso8601String();

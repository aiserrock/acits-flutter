/// The `values-for-selection` payload as a raw JSON map.
///
/// OUR DTO. The endpoint returns a flat object keyed by choice group
/// (`animal_status`, `prescription_types`, …), each a list of
/// `{value, display_name}`. The app reads arbitrary groups by key, so the DTO
/// keeps the decoded body verbatim rather than a fixed typed shape.
class SelectionValuesDto {
  const SelectionValuesDto(this.values);

  factory SelectionValuesDto.fromJson(Map<String, dynamic> json) => SelectionValuesDto(json);

  final Map<String, dynamic> values;

  Map<String, dynamic> toJson() => values;
}

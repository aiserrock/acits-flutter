/// OUR DTOs for the animals reference slice.
///
/// These mirror the wire shape (snake_case JSON keys) but are OUR types —
/// generator-agnostic. Nothing here imports the generated swagger_parser code;
/// the adapter is the only place that maps generated models onto these.
library;

export 'animal_attribute_dto.dart';
export 'animal_dto.dart';
export 'animal_image_dto.dart';
export 'applicant_dto.dart';
export 'curator_dto.dart';
export 'image_thumbnails_dto.dart';
export 'species_dto.dart';

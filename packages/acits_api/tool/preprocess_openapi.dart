// Preprocess the OpenAPI spec before swagger_parser generation.
//
// WHY THIS EXISTS
// ---------------
// swagger_parser 1.44 has a bug: when a component schema is used as a
// `multipart/form-data` (or `x-www-form-urlencoded`) request body, the parser
// inlines that schema's properties into the request method parameters AND adds
// the schema name to an internal `_skipDataClasses` list — so the standalone
// data class is never emitted. But the SAME schema is often ALSO returned as a
// JSON response (or nested via `$ref` inside another response, e.g. `Species`
// inside `AnimalRead`), where the generated code still imports the class.
// Result: dangling imports -> `InvalidType` json_serializable errors and a
// build_runner failure. Affected schemas in this spec: Adopter, Adoption,
// AnimalNote, AnimalSitter, Applicant, Curator, Overstay, Prescription,
// ReleaseSerializers, Species, UserSheltersAdminSerializers.
//
// THE FIX
// -------
// For every request body that offers `application/json`, drop the sibling
// non-JSON content variants (`multipart/form-data`, `x-www-form-urlencoded`).
// The parser then treats those schemas as normal JSON bodies and emits the
// data classes. This is safe because the ACITS app's chopper client sends all
// of these writes as JSON — the multipart/urlencoded variants are DRF
// boilerplate the app never uses.
//
// The original `doc/api/openapi.json` is left untouched; generation reads the
// preprocessed copy written to `.gen/openapi.preprocessed.json`.
//
// Usage: dart run tool/preprocess_openapi.dart
//   (wired into `melos genapi` before `dart run swagger_parser`)
import 'dart:convert';
import 'dart:io';

// Single source of truth is the app spec at the repo root — no duplicated copy.
const _sourcePath = '../../doc/api/openapi.json';
const _outputPath = '.gen/openapi.preprocessed.json';

void main() {
  final source = File(_sourcePath);
  if (!source.existsSync()) {
    stderr.writeln('preprocess_openapi: source spec not found at $_sourcePath');
    exit(1);
  }

  final spec = jsonDecode(source.readAsStringSync()) as Map<String, dynamic>;
  final droppedVariants = _stripNonJsonRequestBodies(spec);

  final outFile = File(_outputPath);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(spec));

  stdout.writeln(
    'preprocess_openapi: wrote $_outputPath '
    '(dropped $droppedVariants non-JSON request-body content variants).',
  );
}

/// For every request body that offers `application/json`, remove sibling
/// content types (multipart/form-data, x-www-form-urlencoded). Returns the
/// number of content variants removed.
int _stripNonJsonRequestBodies(Map<String, dynamic> spec) {
  var dropped = 0;
  final paths = spec['paths'];
  if (paths is! Map<String, dynamic>) return dropped;

  for (final ops in paths.values) {
    if (ops is! Map<String, dynamic>) continue;
    for (final op in ops.values) {
      if (op is! Map<String, dynamic>) continue;
      final requestBody = op['requestBody'];
      if (requestBody is! Map<String, dynamic>) continue;
      final content = requestBody['content'];
      if (content is! Map<String, dynamic>) continue;
      if (!content.containsKey('application/json')) continue;

      for (final ct in content.keys.toList()) {
        if (ct != 'application/json') {
          content.remove(ct);
          dropped++;
        }
      }
    }
  }
  return dropped;
}

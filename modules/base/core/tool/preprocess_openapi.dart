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
// Path is relative to this package (modules/base/core), the cwd `melos genapi`
// cd's into before running.
const _sourcePath = '../../../doc/api/openapi.json';
const _outputPath = '.gen/openapi.preprocessed.json';

void main() {
  final source = File(_sourcePath);
  if (!source.existsSync()) {
    stderr.writeln('preprocess_openapi: source spec not found at $_sourcePath');
    exit(1);
  }

  final spec = jsonDecode(source.readAsStringSync()) as Map<String, dynamic>;
  final droppedVariants = _stripNonJsonRequestBodies(spec);
  final relaxedFields = _relaxOverstatedNonNull(spec);

  final outFile = File(_outputPath);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(spec));

  stdout.writeln(
    'preprocess_openapi: wrote $_outputPath '
    '(dropped $droppedVariants non-JSON request-body content variants, '
    'relaxed $relaxedFields overstated non-null fields).',
  );
}

/// The ACITS OpenAPI spec (auto-generated from DRF) marks almost every field
/// `required` + non-nullable, but the backend actually serializes many of them
/// as `null`: an animal with no assigned curator/applicant, blank audit fields
/// (`created_by`), SimpleJWT's `refresh: null` on token refresh, nested file
/// lists, etc. swagger_parser follows the spec strictly and emits `as String` /
/// `as Map<String,dynamic>` casts, so a `null` throws
/// `type 'Null' is not a subtype of type 'String'` inside `fromJson` and the
/// WHOLE response fails to parse (surfaces as a silent UnknownFailure — an empty
/// screen). The old chopper generator was lenient about this; the new one is not.
///
/// Rather than patch schemas one-by-one (56 of ~101 response schemas are
/// affected — a whack-a-mole across every nested type), we relax the ENTIRE spec
/// in one pass: every `required` scalar / nested-object property that isn't
/// already `nullable` is made `nullable: true` and dropped from `required`. This
/// mirrors the old chopper client's global null-tolerance. Domain mappers apply
/// their own fallbacks (`?? ''`) where a non-null value is still needed.
///
/// SCOPE: response schemas only. `*Write` request DTOs and `writeOnly` fields
/// are left untouched — there a non-null field is a real send-side contract, and
/// masking it as nullable would hide genuine request bugs.
///
/// We patch the preprocessed copy — NOT `doc/api/openapi.json` — so the fix
/// survives every `melos genapi`. The real fix belongs on the backend (mark
/// these actually-nullable in the OpenAPI schema); a companion PR tracks that.

/// Property types whose generated `as T` cast throws on a `null` value. Scalars
/// plus nested objects (`$ref` / `allOf`) and arrays. Enums are `$ref` strings,
/// also covered.
bool _isCastRiskyProp(Map<String, dynamic> prop) {
  if (prop.containsKey(r'$ref') || prop.containsKey('allOf')) return true;
  const riskyTypes = {'string', 'integer', 'number', 'boolean', 'array', 'object'};
  final type = prop['type'];
  return type is String && riskyTypes.contains(type);
}

/// One-pass global relax: for every response schema, mark each `required`
/// cast-risky property `nullable: true` and drop it from `required`. Skips
/// `*Write` request schemas whole (send-side contracts). Returns the number of
/// fields relaxed.
int _relaxOverstatedNonNull(Map<String, dynamic> spec) {
  var relaxed = 0;
  final schemas = (spec['components'] as Map<String, dynamic>?)?['schemas'];
  if (schemas is! Map<String, dynamic>) return relaxed;

  schemas.forEach((schemaName, schema) {
    if (schema is! Map<String, dynamic>) return;
    // Leave request/write DTOs strict — non-null there is a real send contract.
    if (schemaName.endsWith('Write')) return;
    final props = schema['properties'];
    if (props is! Map<String, dynamic>) return;

    final required = (schema['required'] as List?)?.cast<String>().toList() ?? <String>[];
    if (required.isEmpty) return;

    for (final field in required.toList()) {
      final prop = props[field];
      if (prop is! Map<String, dynamic>) continue;
      if (prop['nullable'] == true) {
        required.remove(field);
        continue;
      }
      // NOTE: we do NOT skip `writeOnly` fields here. We already skip whole
      // `*Write` schemas above; a `writeOnly` field left inside a READ schema
      // (a DRF quirk — e.g. ApplicantFile.name) is never serialized into the
      // response, so the backend sends `null` there. Relaxing it is required.
      if (!_isCastRiskyProp(prop)) continue;
      prop['nullable'] = true;
      required.remove(field);
      relaxed++;
    }
    schema['required'] = required;
  });
  return relaxed;
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

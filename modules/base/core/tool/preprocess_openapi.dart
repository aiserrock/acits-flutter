// Preprocess the OpenAPI spec before swagger_parser generation.
//
// Transforms (all applied to a copy; doc/api/openapi.json is never edited):
//   1. drop non-JSON request-body variants            (_stripNonJsonRequestBodies)
//   2. relax overstated `required` response fields     (_relaxOverstatedNonNull)
//   3. relax optional non-null fields                  (_relaxOptionalNonNull)
//   4. let nullable enums accept null                  (_allowNullInNullableEnums)
//   5. drop path parameters without a `{placeholder}`  (_dropUnusedPathParameters)
//   6. rename schemas whose name has a space           (_renameSchemasWithSpaces)
//   7. strip readOnly / writeOnly flags                (_stripReadWriteOnly)
// 1-2 date from swagger_parser 1.x; 3-7 keep swagger_parser 2.x output
// behaviourally identical to what the adapters relied on with 1.x.
//
// WHY (1) EXISTS
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
  final relaxedOptional = _relaxOptionalNonNull(spec['components']);
  final nullableEnums = _allowNullInNullableEnums(spec);
  final droppedPathParams = _dropUnusedPathParameters(spec);
  final renamedSchemas = _renameSchemasWithSpaces(spec);
  final strippedAccessFlags = _stripReadWriteOnly(spec);

  final outFile = File(_outputPath);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(spec));

  stdout.writeln(
    'preprocess_openapi: wrote $_outputPath '
    '(dropped $droppedVariants non-JSON request-body content variants, '
    'relaxed $relaxedFields overstated non-null fields, '
    'relaxed $relaxedOptional optional non-null fields, '
    'made $nullableEnums enums accept null, '
    'dropped $droppedPathParams path parameters without a placeholder, '
    'renamed $renamedSchemas schemas with spaces in the name, '
    'stripped $strippedAccessFlags readOnly/writeOnly flags).',
  );
}

/// swagger_parser 2.x honours `readOnly` / `writeOnly`: a schema that has such
/// fields is split into `Foo$Request` (no read-only fields) and `Foo$Response`
/// (no write-only fields). 1.x ignored both flags and emitted ONE model per
/// schema, and the app relies on that:
///  • DRF marks `role` / `shelter` on the worker-registration schema as
///    write-only, yet the backend echoes them back and `UserWorkerDto` reads
///    them from the response;
///  • the write bodies carry read-only placeholders (`id`, `url`, audit fields)
///    exactly as the previous clients sent them.
/// Dropping the flags restores the 1.x contract: one model per schema, every
/// field present in both directions, identical wire bodies. Returns the number
/// of flags removed.
int _stripReadWriteOnly(Object? node) {
  var removed = 0;
  if (node is Map<String, dynamic>) {
    for (final flag in const ['readOnly', 'writeOnly']) {
      if (node[flag] is bool) {
        node.remove(flag);
        removed++;
      }
    }
    for (final value in node.values) {
      removed += _stripReadWriteOnly(value);
    }
  } else if (node is List) {
    for (final value in node) {
      removed += _stripReadWriteOnly(value);
    }
  }
  return removed;
}

/// swagger_parser 2.x validates that every `in: path` parameter has a `{name}`
/// placeholder in its path template and stops otherwise. The DRF spec declares
/// `from` / `to` as path parameters on `GET /api/v1/prescriptions/executions/`
/// (they are really query filters, but the generated client 1.x emitted
/// `@Path('from')` on a template without `{from}` and Retrofit dropped them, so
/// the wire request never carried them). Removing the parameters keeps the
/// request byte-identical to the 1.x client. Returns the number removed.
int _dropUnusedPathParameters(Map<String, dynamic> spec) {
  var dropped = 0;
  final paths = spec['paths'];
  if (paths is! Map<String, dynamic>) return dropped;

  paths.forEach((template, ops) {
    if (ops is! Map<String, dynamic>) return;

    bool unused(Object? param) =>
        param is Map<String, dynamic> &&
        param['in'] == 'path' &&
        param['name'] is String &&
        !template.contains('{${param['name']}}');

    // Path-item level parameters apply to every operation.
    final shared = ops['parameters'];
    if (shared is List) {
      final before = shared.length;
      shared.removeWhere(unused);
      dropped += before - shared.length;
    }
    for (final op in ops.values) {
      if (op is! Map<String, dynamic>) continue;
      final params = op['parameters'];
      if (params is! List) continue;
      final before = params.length;
      params.removeWhere(unused);
      dropped += before - params.length;
    }
  });
  return dropped;
}

/// A component schema name with a space (`Image Thumbnails`) is rejected by
/// swagger_parser 2.x. Rename it to the PascalCase form 1.x generated
/// (`ImageThumbnails`) and rewrite every `$ref` to it. Returns the number of
/// renamed schemas.
int _renameSchemasWithSpaces(Map<String, dynamic> spec) {
  final schemas = (spec['components'] as Map<String, dynamic>?)?['schemas'];
  if (schemas is! Map<String, dynamic>) return 0;

  final renames = <String, String>{};
  for (final name in schemas.keys.toList()) {
    if (!name.contains(' ')) continue;
    final fixed = name
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join();
    if (schemas.containsKey(fixed)) {
      stderr.writeln('preprocess_openapi: cannot rename "$name" to "$fixed" — name already taken');
      exit(1);
    }
    schemas[fixed] = schemas.remove(name);
    renames[name] = fixed;
  }
  if (renames.isEmpty) return 0;

  // JSON pointers escape `/` and `~`; a space stays literal (or becomes %20).
  final refMap = <String, String>{
    for (final e in renames.entries) ...{
      '#/components/schemas/${e.key}': '#/components/schemas/${e.value}',
      '#/components/schemas/${Uri.encodeComponent(e.key)}': '#/components/schemas/${e.value}',
    },
  };
  void walk(Object? node) {
    if (node is Map<String, dynamic>) {
      final ref = node[r'$ref'];
      if (ref is String && refMap.containsKey(ref)) node[r'$ref'] = refMap[ref];
      node.values.forEach(walk);
    } else if (node is List) {
      node.forEach(walk);
    }
  }

  walk(spec);
  return renames.length;
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

/// Marks [prop] nullable. OpenAPI 3.0 ignores every sibling of a bare `$ref`,
/// so a `nullable: true` next to `$ref` has no effect in swagger_parser 2.x (an
/// enum field stayed non-nullable and threw on `null`). Wrap the reference in a
/// single-member `allOf` first; 2.x keeps the referenced type and honours the
/// sibling `nullable`.
void _markNullable(Map<String, dynamic> prop) {
  final ref = prop.remove(r'$ref');
  if (ref != null) {
    prop['allOf'] = [
      <String, dynamic>{r'$ref': ref},
    ];
  }
  prop['nullable'] = true;
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
      _markNullable(prop);
      required.remove(field);
      relaxed++;
    }
    // swagger_parser 2.x rejects an empty `required` array (OpenAPI 3.0 demands
    // at least one entry), so drop the key when every field was relaxed.
    if (required.isEmpty) {
      schema.remove('required');
    } else {
      schema['required'] = required;
    }
  });
  return relaxed;
}

/// swagger_parser 2.x annotates every OPTIONAL but non-nullable property with
/// `@JsonKey(disallowNullValue: true)`, so `fromJson` throws
/// `DisallowedNullValueException` on `"files": null`, `"death_reason": null`,
/// etc. 1.x accepted `null` for every optional field (it typed them `T?` and cast
/// leniently), and DRF does serialize such fields as `null`. Marking the optional
/// properties `nullable: true` restores that tolerance. It does not change the
/// request body: Dart types stay `T?` and `includeIfNull: false` still omits
/// unset fields. Runs after [_relaxOverstatedNonNull], so whatever is still in
/// `required` (the strict `*Write` fields) is left alone. Returns the number of
/// properties relaxed.
int _relaxOptionalNonNull(Object? node) {
  var relaxed = 0;
  if (node is Map<String, dynamic>) {
    final props = node['properties'];
    if (props is Map<String, dynamic>) {
      final required = (node['required'] as List?)?.cast<String>() ?? const <String>[];
      props.forEach((name, prop) {
        if (required.contains(name) || prop is! Map<String, dynamic>) return;
        if (prop['nullable'] == true || !_isCastRiskyProp(prop)) return;
        _markNullable(prop);
        relaxed++;
      });
    }
    for (final value in node.values) {
      relaxed += _relaxOptionalNonNull(value);
    }
  } else if (node is List) {
    for (final value in node) {
      relaxed += _relaxOptionalNonNull(value);
    }
  }
  return relaxed;
}

/// swagger_parser 2.x still emits `disallowNullValue: true` for a nullable
/// property whose type is an ENUM, unless the enum schema itself accepts `null`
/// (`null` listed in `enum`, plus `nullable: true`). After the relax passes,
/// every enum reached through a nullable property — inline, or via `$ref` /
/// single-member `allOf` — gets that treatment, so `"status": null` parses like
/// it did in 1.x. Returns the number of enum schemas changed.
int _allowNullInNullableEnums(Map<String, dynamic> spec) {
  final schemas = (spec['components'] as Map<String, dynamic>?)?['schemas'];
  if (schemas is! Map<String, dynamic>) return 0;

  final touched = <Map<String, dynamic>>{};
  void allowNull(Map<String, dynamic> enumSchema) {
    final values = enumSchema['enum'];
    if (values is! List) return;
    if (!values.contains(null)) values.add(null);
    enumSchema['nullable'] = true;
    touched.add(enumSchema);
  }

  Map<String, dynamic>? resolve(Object? ref) {
    const prefix = '#/components/schemas/';
    if (ref is! String || !ref.startsWith(prefix)) return null;
    final target = schemas[ref.substring(prefix.length)];
    return target is Map<String, dynamic> ? target : null;
  }

  void visit(Object? node) {
    if (node is Map<String, dynamic>) {
      if (node['nullable'] == true) {
        if (node['enum'] is List) allowNull(node);
        final direct = resolve(node[r'$ref']);
        if (direct != null) allowNull(direct);
        final allOf = node['allOf'];
        if (allOf is List) {
          for (final member in allOf) {
            if (member is Map<String, dynamic>) {
              final target = resolve(member[r'$ref']);
              if (target != null) allowNull(target);
            }
          }
        }
      }
      node.values.forEach(visit);
    } else if (node is List) {
      node.forEach(visit);
    }
  }

  visit(spec['components']);
  return touched.length;
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

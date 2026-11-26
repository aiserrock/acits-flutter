// Fails when the workspace package graph breaks the layering described in
// ARCHITECTURE.md. Run from the repository root: `dart run tool/check_package_graph.dart`.
import 'dart:io';

/// Layer of every workspace package. A package may depend only on packages of a
/// strictly lower layer, plus the same-layer edges listed in [allowedSameLayer].
const layers = <String, int>{
  // 0 — leaf infrastructure: no internal dependencies at all.
  'util': 0,
  'network': 0,
  'navigation': 0,
  'localization': 0,
  'di': 0,
  'observability': 0,
  // 1 — shared kernel.
  'core': 1,
  'ui_kit': 1,
  // 2 — features.
  'animals': 2,
  'applicants': 2,
  'auth': 2,
  'prescriptions': 2,
  'personal': 2,
  // 3 — media composes other features (photo upload, search adapters).
  'media': 3,
  // 4 — app composition: services that bridge features.
  'app_services': 4,
  // 5 — screens that compose features, router tree.
  'shell': 5,
  // 6 — the application: flavors, bootstrap, DI composition.
  'acits_flutter': 6,
};

const allowedSameLayer = <String, Set<String>>{};

void main() {
  final pubspecs = [
    File('pubspec.yaml'),
    ...Directory('modules').listSync().whereType<Directory>().map((d) => File('${d.path}/pubspec.yaml')),
    ...Directory('modules/base').listSync().whereType<Directory>().map((d) => File('${d.path}/pubspec.yaml')),
  ].where((f) => f.existsSync()).toList();

  final graph = <String, Set<String>>{};
  for (final file in pubspecs) {
    final text = file.readAsStringSync();
    final name = RegExp(r'^name:\s*(\S+)', multiLine: true).firstMatch(text)!.group(1)!;
    final runtime = text.split(RegExp(r'^dev_dependencies:', multiLine: true)).first;
    graph[name] = RegExp(
      r'^  ([a-z_0-9]+):\s*\n\s+path:',
      multiLine: true,
    ).allMatches(runtime).map((m) => m.group(1)!).toSet();
  }

  final errors = <String>[];
  for (final MapEntry(key: from, value: deps) in graph.entries) {
    final fromLayer = layers[from];
    if (fromLayer == null) {
      errors.add('$from is not listed in tool/check_package_graph.dart — assign it a layer.');
      continue;
    }
    for (final to in deps) {
      final toLayer = layers[to];
      if (toLayer == null) {
        errors.add('$from -> $to: $to has no layer.');
      } else if (toLayer > fromLayer) {
        errors.add('$from (layer $fromLayer) must not depend on $to (layer $toLayer).');
      } else if (toLayer == fromLayer && !(allowedSameLayer[from]?.contains(to) ?? false)) {
        errors.add('$from and $to share layer $fromLayer; same-layer packages must not depend on each other.');
      }
    }
  }

  if (errors.isEmpty) {
    stdout.writeln('Package graph OK: ${graph.length} packages, no forbidden edges.');
    return;
  }
  stderr.writeln('Package graph violations:');
  for (final error in errors) {
    stderr.writeln('  - $error');
  }
  exitCode = 1;
}

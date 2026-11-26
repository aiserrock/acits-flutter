#!/usr/bin/env bash
# Single source of the quality gate: melos scripts and CI jobs both call this,
# so local runs and CI check exactly the same files with the same flags.
#
#   tool/ci/gate.sh format        # format hand-written code
#   tool/ci/gate.sh format-check  # fail on unformatted code
#   tool/ci/gate.sh analyze       # strict analysis + package layering
#   tool/ci/gate.sh test          # unit/widget tests, goldens excluded
#   tool/ci/gate.sh goldens       # golden tests only (Linux renders them)
#   tool/ci/gate.sh all           # format-check + analyze + test
#
# Uses fvm when it is installed (local), plain flutter/dart otherwise (CI).
set -euo pipefail

cd "$(dirname "$0")/../.."

if command -v fvm >/dev/null 2>&1 && [ -f .fvmrc ]; then
  FLUTTER=(fvm flutter)
  DART=(fvm dart)
else
  FLUTTER=(flutter)
  DART=(dart)
fi

# Hand-written Dart files. Generated code is excluded: its formatting follows
# the generator version and is not maintained by hand.
dart_sources() {
  find lib test modules tool -name '*.dart' \
    ! -name '*.g.dart' \
    ! -name '*.config.dart' \
    ! -name '*.swagger.dart' \
    ! -name '*.gen.dart' \
    ! -name 'locale_keys.g.dart' \
    ! -name 'firebase_options.dart' \
    ! -path '*/generated/*' \
    ! -path '*/.dart_tool/*' \
    ! -path '*/build/*' \
    -print0
}

group() { if [ -n "${GITHUB_ACTIONS:-}" ]; then echo "::group::$1"; else echo "── $1"; fi; }
endgroup() { if [ -n "${GITHUB_ACTIONS:-}" ]; then echo "::endgroup::"; fi; }

format() { dart_sources | xargs -0 "${DART[@]}" format -l 120; }

format_check() { dart_sources | xargs -0 "${DART[@]}" format --output=none --set-exit-if-changed -l 120; }

analyze() {
  "${FLUTTER[@]}" analyze --fatal-infos --fatal-warnings
  "${DART[@]}" run tool/check_package_graph.dart
}

# Root app plus every workspace package with a test/ folder. `modules/base/*`
# has its own glob: base is a container, its packages sit one level deeper.
run_tests() {
  "${FLUTTER[@]}" test
  for p in packages/* modules/* modules/base/*; do
    if [ -d "$p/test" ]; then
      group "flutter test ($p)"
      (cd "$p" && "${FLUTTER[@]}" test --exclude-tags golden)
      endgroup
    fi
  done
}

goldens() { (cd modules/ui_kit && "${FLUTTER[@]}" test --tags golden "$@"); }

case "${1:-}" in
  format) format ;;
  format-check) format_check ;;
  analyze) analyze ;;
  test) run_tests ;;
  goldens) shift; goldens "$@" ;;
  all) format_check && analyze && run_tests ;;
  *)
    echo "usage: $0 {format|format-check|analyze|test|goldens|all}" >&2
    exit 64
    ;;
esac

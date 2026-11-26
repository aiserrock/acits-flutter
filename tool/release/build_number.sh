#!/usr/bin/env bash
# Prints the marketing version and the build number of a release build.
#
# The build number is shared by Google Play, the App Store and RuStore and has
# to grow with every build: it is a fixed offset above every build number that
# was ever distributed, plus the run number of the release workflow.
#
# usage: build_number.sh <run-number>
set -euo pipefail

# Highest build number distributed before this pipeline existed was below 1000.
readonly BUILD_NUMBER_OFFSET=1000

run_number="${1:?usage: build_number.sh <run-number>}"
if ! [[ "$run_number" =~ ^[0-9]+$ ]]; then
  echo "run number must be a positive integer, got: $run_number" >&2
  exit 1
fi

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
version_line="$(grep -E '^version:[[:space:]]' "$root/pubspec.yaml" | head -1)"
version="${version_line#version:}"
version="${version//[[:space:]]/}"
version="${version%%+*}"

if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "pubspec.yaml version is not MAJOR.MINOR.PATCH: $version" >&2
  exit 1
fi

echo "version=$version"
echo "build_number=$((BUILD_NUMBER_OFFSET + run_number))"

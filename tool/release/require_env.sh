#!/usr/bin/env bash
# Fails with one message that names every missing variable, so a release run
# stops at the first step instead of half-way through a build.
#
# usage: require_env.sh VAR [VAR...]
set -euo pipefail

missing=()
for name in "$@"; do
  if [ -z "${!name:-}" ]; then
    missing+=("$name")
  fi
done

if [ "${#missing[@]}" -gt 0 ]; then
  echo "Missing required secrets or variables: ${missing[*]}" >&2
  echo "See doc/release.md for what each one is and where to get it." >&2
  exit 1
fi

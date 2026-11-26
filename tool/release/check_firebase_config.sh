#!/usr/bin/env bash
# Refuses a release build that would ship with the placeholder Firebase
# configuration from the committed *.example templates.
#
# usage: check_firebase_config.sh <file> [<file>...]
set -euo pipefail

status=0
for file in "$@"; do
  if [ ! -s "$file" ]; then
    echo "Firebase config is missing or empty: $file" >&2
    status=1
  elif grep -qE 'YOUR_(PROJECT_NUMBER|APP_ID|API_KEY|PROJECT_ID)' "$file"; then
    echo "Firebase config still holds template placeholders: $file" >&2
    status=1
  fi
done

if [ "$status" -ne 0 ]; then
  echo "Set the GOOGLE_SERVICES_JSON_* / GOOGLE_SERVICE_INFO_PLIST_* secrets (see doc/release.md)." >&2
fi
exit "$status"

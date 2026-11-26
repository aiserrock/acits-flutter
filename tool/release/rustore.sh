#!/usr/bin/env bash
# Publishes a build to RuStore through its public API.
#
#   rustore.sh draft <apk>      create a draft version with manual publication,
#                               upload the APK and send it to moderation
#   rustore.sh publish <code>   publish the moderated version with that versionCode
#
# Environment: RUSTORE_KEY_ID, RUSTORE_PRIVATE_KEY (base64 PKCS#8, as shown once
# in the RuStore console), RUSTORE_PACKAGE_NAME, optional RUSTORE_WHATS_NEW.
set -euo pipefail

readonly API="https://public-api-m.rustore.ru/public"

for name in RUSTORE_KEY_ID RUSTORE_PRIVATE_KEY RUSTORE_PACKAGE_NAME; do
  if [ -z "${!name:-}" ]; then
    echo "$name is not set" >&2
    exit 1
  fi
done

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

# Fails unless the response is {"code":"OK"}; never prints the token.
expect_ok() {
  local response="$1" action="$2"
  if [ "$(jq -r '.code // empty' <<<"$response")" != "OK" ]; then
    echo "RuStore: $action failed: $(jq -c '{code, message}' <<<"$response" 2>/dev/null || echo "$response")" >&2
    exit 1
  fi
}

# The token is a JWE valid for 15 minutes; the signature covers keyId + timestamp.
fetch_token() {
  local timestamp signature response
  timestamp="$(date -u +"%Y-%m-%dT%H:%M:%S.000+00:00")"
  {
    echo "-----BEGIN PRIVATE KEY-----"
    printf '%s\n' "$RUSTORE_PRIVATE_KEY" | fold -w 64
    echo "-----END PRIVATE KEY-----"
  } >"$workdir/key.pem"
  signature="$(printf '%s%s' "$RUSTORE_KEY_ID" "$timestamp" | openssl dgst -sha512 -sign "$workdir/key.pem" | openssl base64 -A)"
  rm -f "$workdir/key.pem"

  response="$(curl --silent --show-error --fail-with-body \
    --request POST "$API/auth" \
    --header 'Content-Type: application/json' \
    --data "$(jq -n --arg k "$RUSTORE_KEY_ID" --arg t "$timestamp" --arg s "$signature" '{keyId: $k, timestamp: $t, signature: $s}')")"
  expect_ok "$response" "authorization"
  jq -r '.body.jwe' <<<"$response"
}

api() {
  local method="$1" path="$2"
  shift 2
  curl --silent --show-error --fail-with-body \
    --request "$method" "$API/v1/application/$RUSTORE_PACKAGE_NAME/$path" \
    --header "Public-Token: $TOKEN" "$@"
}

command="${1:?usage: rustore.sh draft <apk> | publish <versionCode>}"
TOKEN="$(fetch_token)"

case "$command" in
  draft)
    apk="${2:?usage: rustore.sh draft <apk>}"
    [ -f "$apk" ] || { echo "APK not found: $apk" >&2; exit 1; }

    body="$(jq -n --arg notes "${RUSTORE_WHATS_NEW:-}" \
      '{publishType: "MANUAL"} + (if $notes == "" then {} else {whatsNew: $notes} end)')"
    response="$(api POST version --header 'Content-Type: application/json' --data "$body")"
    expect_ok "$response" "creating the draft version"
    # The docs show the id both as a bare number and as body.versionId.
    version_id="$(jq -r '.body | if type == "object" then .versionId else . end' <<<"$response")"
    if ! [[ "$version_id" =~ ^[0-9]+$ ]]; then
      echo "RuStore: unexpected draft response, no version id." >&2
      exit 1
    fi

    response="$(api POST "version/$version_id/apk?servicesType=Unknown&isMainApk=true" --form "file=@$apk")"
    expect_ok "$response" "uploading the APK"

    response="$(api POST "version/$version_id/commit")"
    expect_ok "$response" "sending the draft to moderation"
    echo "RuStore: version $version_id sent to moderation (manual publication)."
    ;;

  publish)
    version_code="${2:?usage: rustore.sh publish <versionCode>}"
    response="$(api GET 'version?filterTestingType=ALL&page=0&size=100')"
    expect_ok "$response" "listing versions"
    match="$(jq -c --argjson code "$version_code" '[.body.content[] | select(.versionCode == $code)] | first // empty' <<<"$response")"
    if [ -z "$match" ]; then
      echo "RuStore: no version with versionCode $version_code." >&2
      exit 1
    fi
    status="$(jq -r '.versionStatus' <<<"$match")"
    version_id="$(jq -r '.versionId' <<<"$match")"
    case "$status" in
      ACTIVE | PARTIAL_ACTIVE)
        echo "RuStore: version $version_id is already published ($status)."
        ;;
      READY_FOR_PUBLICATION)
        response="$(api POST "version/$version_id/publish")"
        expect_ok "$response" "publishing"
        echo "RuStore: version $version_id published."
        ;;
      *)
        echo "RuStore: version $version_id is not ready for publication (status $status)." >&2
        exit 1
        ;;
    esac
    ;;

  *)
    echo "unknown command: $command" >&2
    exit 1
    ;;
esac

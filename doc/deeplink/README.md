# Deep links

What the app accepts today, and what has to be settled before the first store release.
Schemes, hosts and paths become a contract once links are in users' mail: changing them
later breaks every link already sent.

## Current contract

| Link | Sent by | Handled by |
| --- | --- | --- |
| `https://<host>/api/v1/users/verify-email/<uidb64>/<sidb64>/<token>/` | backend, sign-up e-mail | Android App Link filter (`*.acits.ru`, `android/app/src/main/AndroidManifest.xml`), `DeepLinkService` → `/email-confirmation?link=…` → `EmailConfirmRepository` (https, `acits.ru` or `*.acits.ru`, GET without redirects) |
| `https://<host>/api/v1/users/verify-worker/<uidb64>/<sidb64>/<token>/` | backend, shelter-worker confirmation | not handled: opens in the browser |
| password reset | — | no flow in the app yet |

Hosts per environment (`path.txt`): prod `app.acits.ru`, stage `stage.app.acits.ru`, dev
`dev-N.app.acits.ru` (N = 0..3). Application ids: `ru.acits` (prod), `ru.acits.dev` (dev);
iOS team `45G32KJDV7`.

## State

- **Android:** one `autoVerify` filter for `https://*.acits.ru/api/v1/users/verify-email*`.
  Verification fails until `assetlinks.json` is served (see below), so Android shows the
  disambiguation dialog instead of opening the app.
- **iOS:** `ios/Runner/Runner.entitlements` is empty — no associated domains, so links open
  Safari. `Runner.entitlements.example` lists `app.acits.ru` and `dev.acits.ru`; the second
  does not match the dev hosts above.
- **Web:** nothing is served from `/.well-known/`. `nginx.conf` falls every unknown path
  back to `index.html`, which would also answer `/.well-known/*` with HTML.
- **Custom scheme:** none.

The drafts in this folder (`assetlinks.json`, `apple-app-site-association`) are templates;
their SHA-256 is not confirmed to be the Play App Signing key.

## Before the first release (owner)

1. **Path contract with the backend.** Keep `/api/v1/users/...` or move links to a web
   path (e.g. `/verify-email/...`) that the web app also serves. Decide whether
   `verify-worker` and password reset open the app.
2. **Hosts.** Final prod and stage hosts the backend puts into e-mails.
3. **`assetlinks.json`** at `https://<each host>/.well-known/assetlinks.json`, served as
   `application/json` without redirects, with the **Play App Signing** SHA-256 (Play Console
   → Setup → App signing) for `ru.acits`, plus the upload/debug key for `ru.acits.dev`.
   With `android:host="*.acits.ru"`, Android verifies `https://acits.ru/.well-known/…` too.
4. **`apple-app-site-association`** at `https://<each host>/.well-known/apple-app-site-association`
   (no extension, `application/json`, no redirects). Enable *Associated Domains* on both App
   IDs in the developer portal, then add
   `com.apple.developer.associated-domains` = `applinks:<host>` for each host to
   `ios/Runner/Runner.entitlements`. Adding the entitlement before the capability is
   enabled breaks signing.
5. **nginx / CDN:** serve `/.well-known/` before the SPA fallback, e.g.

   ```nginx
   location ^~ /.well-known/ {
       default_type application/json;
       try_files $uri =404;
   }
   ```

6. **Custom scheme** (optional): only if links must work where https links cannot (e.g.
   from another app). Pick the name once; it cannot be changed after release.

## Testing

```sh
adb shell pm verify-app-links --re-verify ru.acits.dev
adb shell pm get-app-links ru.acits.dev
adb shell am start -a android.intent.action.VIEW \
  -d "https://stage.app.acits.ru/api/v1/users/verify-email/<uidb64>/<sidb64>/<token>/"
xcrun simctl openurl booted "https://stage.app.acits.ru/api/v1/users/verify-email/…"
```

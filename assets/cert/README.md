# Debug SSL certificates

This directory holds developer-local Charles Proxy / mitmproxy root certificates
(`*.pem`) used only in the **dev** flavor to inspect HTTPS traffic.

These files are **gitignored** and intentionally not shipped with the repository
(see the root `.gitignore`). They are not required to build or run the app in the
default configuration — the dev SSL override in `test/dev/ssl/` simply skips
pinning when no certificate is present.

If you need to proxy dev traffic through Charles, export your own Charles root
certificate as PEM and drop it here; then reference it from
`test/dev/res/cert_res.dart`.

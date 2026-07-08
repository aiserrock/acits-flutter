# cirrusci/flutter is unmaintained and its pinned 3.3.1 tag predates the SDK
# this project needs (.fvmrc / CI pin: 3.44.0). ghcr.io/cirruslabs/flutter is
# the maintained successor image, tagged after the Flutter SDK version.
FROM ghcr.io/cirruslabs/flutter:3.44.0 AS build
WORKDIR /usr/src/app
COPY . .
RUN flutter pub get
# prod flavor (lib/main.dart) — same entry point used for release Android/iOS
# builds and the tag-triggered GitHub Pages deploy (see .github/workflows/ci.yml).
# --web-renderer was removed in newer Flutter SDKs (CanvasKit is the only
# renderer now); flavor for web builds is selected via -t/--target, not
# --flavor, which isn't supported by `flutter build web`.
RUN flutter build web -t lib/main.dart --release

FROM nginx:1.27
COPY --from=build /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/build/web/ /usr/share/nginx/html/

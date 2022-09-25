FROM cirrusci/flutter:3.3.1 AS build
WORKDIR /usr/src/app
COPY . .
RUN flutter build web -t test/dev/main.dart --web-renderer canvaskit

FROM nginx:1.20.0
COPY --from=build /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/build/web/ /usr/share/nginx/html/


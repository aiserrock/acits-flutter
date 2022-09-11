FROM cirrusci/flutter:3.3.0 AS build
WORKDIR /usr/src/app
COPY . .
RUN flutter build web -t lib/main.dart

FROM nginx:1.20.0
COPY --from=build /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/build/web/ /usr/share/nginx/html/


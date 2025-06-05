FROM ubuntu:22.04

# Instalar dependencias, JDK, Android SDK, Flutter
# (esto puede ser extenso y complejo)

# Copiar tu código Flutter
COPY . /app
WORKDIR /app

# Instalar dependencias flutter
RUN flutter pub get

# Compilar APK release
CMD ["flutter", "build", "apk", "--release"]

## Stage 1: Build Flutter Web
#FROM ghcr.io/cirruslabs/flutter:3.22.1 AS builder
#
#ARG API_URL
#
#WORKDIR /app
#
#COPY pubspec.* ./
#RUN flutter pub get
#
#COPY . .
#
#RUN flutter precache --web
#
#RUN flutter build web --release --dart-define=API_URL=$API_URL
#
## Stage 2: Serve with Nginx
#FROM nginx:stable-alpine
#
#COPY --from=builder /app/build/web /usr/share/nginx/html
#COPY nginx/default.conf /etc/nginx/conf.d/default.conf
#
#EXPOSE 80
#
#CMD ["nginx", "-g", "daemon off;"]

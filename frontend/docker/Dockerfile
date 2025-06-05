# Stage 1: Build Flutter app
FROM ghcr.io/cirruslabs/flutter:3.22.1 AS builder

# Solución para el error de permisos en git config
RUN git config --global --add safe.directory /sdks/flutter

WORKDIR /app

# Copiar pubspec.yaml y pubspec.lock para instalar dependencias primero
COPY pubspec.* ./

RUN flutter pub get

# Copiar el resto de archivos
COPY . .

# Build release web app (o la plataforma que uses, por ejemplo web)
RUN flutter build web --release

# Stage 2: Serve app with nginx
FROM nginx:stable-alpine

# Copiar build generado a nginx html folder
COPY --from=builder /app/build/web /usr/share/nginx/html

# Exponer puerto 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

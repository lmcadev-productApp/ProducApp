# Stage 1: Build Flutter app
FROM ghcr.io/cirruslabs/flutter:3.22.1 AS builder

RUN git config --global --add safe.directory /sdks/flutter

WORKDIR /app

COPY pubspec.* ./

RUN flutter pub get

COPY . .

RUN flutter build web --release

# Stage 2: Serve app with nginx
FROM nginx:stable-alpine

COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
